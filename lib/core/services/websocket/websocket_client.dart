import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:chat_app/config/urls.dart';
import 'package:chat_app/core/services/websocket/models/websocket_message.dart';
import 'package:chat_app/data/collectivity/collectivity_service.dart';
import 'package:chat_app/data/collectivity/dyad.dart';
import 'package:chat_app/data/participant/participant_service.dart';
import 'package:chat_app/data/person/person_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';

import '../../../constants/enums/ws_message_response_type.dart';
import '../../../constants/shared_pref_key.dart';
import '../../../data/collectivity/group.dart';
import '../../../data/message/message.dart';
import '../../../data/message/message_service.dart';
import '../../../data/person/person.dart';
import '../../../data/person/person_service.dart';
import '../../../features/auth/controllers/auth_controller.dart';
import '../notification/notification_service.dart';

class WebSocketClient extends GetxService {
  AuthController authController = Get.find<AuthController>();
  PersonService personService = Get.find<PersonService>();
  MessageService messageService = Get.find<MessageService>();
  CollectivityService collectivityService = Get.find<CollectivityService>();
  PersonRepository personRepository = Get.find<PersonRepository>();
  ParticipantService participantService = Get.find<ParticipantService>();

  RxBool isWsConnected = false.obs;
  IOWebSocketChannel? channel;

  bool _isConnecting = false;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  WebSocketClient() {
    ever(authController.isLoggedIn, (isLoggedIn) {
      if (isLoggedIn) {
        print("ws connect");
        _connect();
      } else {
        if (channel != null) {
          print("ws close");
          close();
        }
      }
    }
    );
    ever(isWsConnected, (isConnected){
      if(isConnected){
        NotificationService.instance.showLocalNotification(id: 3, title: "Websocket connected", body: "body");
      }else{
        NotificationService.instance.showLocalNotification(id: 3, title: "Websocket not connected", body: "body");
      }

    });

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
          (List<ConnectivityResult> results) {
        if (results.any((result) => result != ConnectivityResult.none) &&
            !isWsConnected.value&&authController.isLoggedIn.value) {
          print("Connectivity restored. Attempting to reconnect...");
          _connect();
        }
      },
    );

  }

  Future<void> _connect() async {
    if (isWsConnected.value || _isConnecting) return;
    _isConnecting = true;
    //print('Function called from: ${StackTrace.current}');
    String accessToken = await authController.getAccessToken();
    final prefs = await SharedPreferences.getInstance();

    String fcmToken=prefs.getString(SharedPrefKey.fcmKey)??'';
    int lastFetchTime=prefs.getInt(SharedPrefKey.lastFetchTimeKey)??100;
    final headers = {
      'Authorization': 'Bearer $accessToken',
      'device-type' : 'PHONE',
      'fcm-token' : fcmToken,
      'last-fetch-time': lastFetchTime
    };

    try {
      final webSocket =
          await WebSocket.connect(Url.websocket, headers: headers);
      channel = IOWebSocketChannel(webSocket);
      channel?.stream.listen(
        (message) {
          handleMessage(message);
        },
        onError: (error) {
          print("WebSocket: Error occurred: $error");
          _setDisconnected();
          _attemptReconnection();
        },
        onDone: () {
          print("WebSocket: Connection closed.");
          _setDisconnected();
          _attemptReconnection();
        },
      );
      isWsConnected.value=true;
      print("ws connected");
    } catch (e) {
      print("WebSocket connection failed: $e");
      _setDisconnected();
      _attemptReconnection();
    }finally{
      _isConnecting = false;
    }
  }

  void sendWebsocketMessage(WebsocketMessage message) {
    String jsonMessage = jsonEncode(message.toJson());
    channel?.sink.add(jsonMessage);
    print("send  " + jsonMessage);
  }

  void close() {
    channel?.sink.close();
  }

  void _attemptReconnection() {
    if (!isWsConnected.value) {
      print("Attempting to reconnect...");
      Future.delayed(Duration(seconds: 10), () {
        if (isWsConnected.value == false) {
          _connect();
        }
      });
    }
  }

  @override
  void onClose() {
    print("on close");
    _connectivitySubscription.cancel();
    super.onClose();
  }

  void _setDisconnected() {
    isWsConnected.value = false;
    channel = null;
  }

  void handleMessage(dynamic message) async {
    final jsonData = jsonDecode(message);
    print(jsonData);
    var data = jsonData["data"];
    var timestamp=jsonData["timestamp"];
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
        Dyad dyad = Dyad.fromJson(data);
        dyad.setId(int.parse(jsonData["requestId"].toString()));
        await collectivityService.fetchDyad(dyad);
        break;
      case WsMessageResponseType.NEW_DYAD:
        Dyad dyad = Dyad.fromJson(data);
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
      default:
    }
  }

  Future<void> setLastSyncTime(dynamic timestamp) async {
    print(timestamp);
    try{
      int? unix=int.tryParse(timestamp.toString());
      if(unix==null) {
        print("timestamp error: $timestamp");
        return;
      }
      final prefs = await SharedPreferences.getInstance();
      prefs.setInt(SharedPrefKey.lastFetchTimeKey, unix);
    }catch(e){
      print(e);
    }
  }
}
