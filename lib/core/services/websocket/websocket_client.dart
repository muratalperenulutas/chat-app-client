import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:chat_app/config/urls.dart';
import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/core/services/websocket/models/websocket_message.dart';
import 'package:chat_app/data/collectivity/collectivity_service.dart';
import 'package:chat_app/data/collectivity/dyad.dart';
import 'package:chat_app/data/participant/participant_service.dart';
import 'package:chat_app/data/person/person_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../constants/enums/ws_message_response_type.dart';
import '../../../constants/shared_pref_key.dart';
import '../../../data/collectivity/group.dart';
import '../../../data/message/message.dart';
import '../../../data/message/message_service.dart';
import '../../../data/person/person.dart';
import '../../../data/person/person_service.dart';
import '../../../features/auth/controllers/auth_controller.dart';

class WebSocketClient {
  final ProviderContainer container;
  late final ProviderSubscription authSubscription;
  late final PersonService personService;
  late final MessageService messageService;
  late final CollectivityService collectivityService;
  late final PersonRepository personRepository;
  late final ParticipantService participantService;

  WebSocketClient(this.container) {
    personService = getIt<PersonService>();
    messageService = getIt<MessageService>();
    collectivityService = getIt<CollectivityService>();
    personRepository = getIt<PersonRepository>();
    participantService = getIt<ParticipantService>();

    _initialize();
  }

  bool isWsConnected = false;
  WebSocketChannel? channel;

  bool _isConnecting = false;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  void _initialize() {
    authSubscription = container.listen(authControllerProvider,
        (previous, next) {
      if (next.isLoggedIn) {
        debugPrint("ws connect");
        _connect();
      } else {
        if (channel != null) {
          debugPrint("ws close");
          close();
        }
      }
    }, fireImmediately: true);

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> results) {
        if (results.any((result) => result != ConnectivityResult.none) &&
            !isWsConnected &&
            container.read(authControllerProvider).isLoggedIn) {
          debugPrint("Connectivity restored. Attempting to reconnect...");
          _connect();
        }
      },
    );
  }

  Future<void> _connect() async {
    if (isWsConnected || _isConnecting) return;
    _isConnecting = true;
    //print('Function called from: ${StackTrace.current}')

    String deviceType = "unknown";
    if (kIsWeb) {
      deviceType = "web";
    } else if (Platform.isAndroid) {
      deviceType = "android";
    } else if (Platform.isIOS) {
      deviceType = "ios";
    } else if (Platform.isWindows) {
      deviceType = "windows";
    } else if (Platform.isMacOS) {
      deviceType = "macos";
    } else if (Platform.isLinux) {
      deviceType = "linux";
    }

  String accessToken =
    await container.read(authControllerProvider.notifier).getAccessToken();
    final prefs = await SharedPreferences.getInstance();

    String fcmToken = prefs.getString(SharedPrefKey.fcmKey) ?? '';
    int lastFetchTime = prefs.getInt(SharedPrefKey.lastFetchTimeKey) ?? 100;

    try {
      final uri = Uri.parse(Url.websocket).replace(queryParameters: {
        'last-fetch-time': lastFetchTime.toString(),
        "device-type":deviceType
      });

      var protocols = [
        'websocket',
        'access-token$accessToken',
        'fcm-token$fcmToken'
      ];
      channel = WebSocketChannel.connect(uri, protocols: protocols);

      await channel?.ready;

      channel?.stream.listen(
        (message) {
          handleMessage(message);
        },
        onError: (error) {
          debugPrint("WebSocket: Error occurred: $error");
          _setDisconnected();
          _attemptReconnection();
        },
        onDone: () {
          debugPrint("WebSocket: Connection closed.");
          _setDisconnected();
          _attemptReconnection();
        },
      );
      isWsConnected = true;
      debugPrint("ws connected");
    } catch (e) {
      debugPrint("WebSocket connection failed: $e");
      _setDisconnected();
      _attemptReconnection();
    } finally {
      _isConnecting = false;
    }
  }

  void sendWebsocketMessage(WebsocketMessage message) {
    String jsonMessage = jsonEncode(message.toJson());
    channel?.sink.add(jsonMessage);
    debugPrint("send  " + jsonMessage);
  }

  void close() {
    channel?.sink.close();
  }

  void _attemptReconnection() {
    if (!isWsConnected) {
      debugPrint("Attempting to reconnect...");
      Future.delayed(Duration(seconds: 10), () {
        if (isWsConnected == false) {
          _connect();
        }
      });
    }
  }

  void _setDisconnected() {
    isWsConnected = false;
    channel = null;
  }

  void handleMessage(dynamic message) async {
    final jsonData = jsonDecode(message);
    debugPrint(jsonData);
    var data = jsonData["data"];
    var timestamp = jsonData["timestamp"];
    setLastSyncTime(timestamp);
    switch (WsMessageResponseType.fromString(jsonData['type'])) {
      case WsMessageResponseType.USER_FOUND:
        if (message != null) {
          Person person = Person.fromJson(data);
          personService.fetchPerson(person);
        }
        break;
      case WsMessageResponseType.MESSAGE_SEND:
        Message message = Message.fromJson(data);
        messageService.updateMessage(
            int.parse(jsonData["requestId"].toString()), message);
        break;
      case WsMessageResponseType.NEW_MESSAGE:
        Message message = Message.fromJson(data);
        await messageService.saveMessage(message);
        break;
      case WsMessageResponseType.GROUP_CREATED:
        //int.parse(jsonData["requestId"].toString())
        Group group = Group.fromJson(data);
        await collectivityService.saveGroup(group);
        break;
      case WsMessageResponseType.NEW_GROUP:
        Group group = Group.fromJson(data);
        await collectivityService.saveGroup(group);
        break;
      case WsMessageResponseType.DYAD_CREATED:
    Dyad dyad =
      Dyad.fromJson(data, container.read(authControllerProvider).myId);
        dyad.setId(int.parse(jsonData["requestId"].toString()));
        await collectivityService.fetchDyad(dyad);
        break;
      case WsMessageResponseType.NEW_DYAD:
    Dyad dyad =
      Dyad.fromJson(data, container.read(authControllerProvider).myId);
        await collectivityService.saveDyad(dyad);
        break;
      case WsMessageResponseType.SYNC_DYAD:
        List<Map<String, dynamic>> dtos = (data["dtos"] as List)
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
        collectivityService.syncDyadList(dtos);
        break;
      case WsMessageResponseType.NEW_PARTICIPANT:
        List<Map<String, dynamic>> participants = (data["participants"] as List)
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
        participantService.addParticipants(participants);
        break;
      case WsMessageResponseType.SYNC_MESSAGES:
        List<Map<String, dynamic>> dtos = (data["dtos"] as List)
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
        messageService.syncMessages(dtos);
        break;
      case WsMessageResponseType.SYNC_GROUP:
        List<Map<String, dynamic>> dtos = (data["dtos"] as List)
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
        collectivityService.saveGroupList(dtos);
        break;
    }
  }

  Future<void> setLastSyncTime(dynamic timestamp) async {
    debugPrint(timestamp.toString());
    try {
      int? unix = int.tryParse(timestamp.toString());
      if (unix == null) {
        debugPrint("timestamp error: $timestamp");
        return;
      }
      final prefs = await SharedPreferences.getInstance();
      prefs.setInt(SharedPrefKey.lastFetchTimeKey, unix);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void dispose() {
    _connectivitySubscription.cancel();
  }
}