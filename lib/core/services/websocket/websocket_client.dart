import 'dart:convert';
import 'dart:io';
import 'package:chat_app/config/urls.dart';
import 'package:chat_app/core/services/websocket/models/websocket_message.dart';
import 'package:chat_app/data/collectivity/collectivity_service.dart';
import 'package:chat_app/data/collectivity/dyad.dart';
import 'package:chat_app/data/participant/participant_service.dart';
import 'package:chat_app/data/person/person_repository.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';

import '../../../constants/enums/ws_message_response_type.dart';
import '../../../data/collectivity/group.dart';
import '../../../data/message/message.dart';
import '../../../data/message/message_service.dart';
import '../../../data/person/person.dart';
import '../../../data/person/person_service.dart';
import '../../../features/auth/controllers/auth_controller.dart';

class WebSocketClient extends GetxService {
  AuthController authController = Get.find<AuthController>();
  PersonService personService = Get.find<PersonService>();
  MessageService messageService = Get.find<MessageService>();
  CollectivityService collectivityService = Get.find<CollectivityService>();
  PersonRepository personRepository = Get.find<PersonRepository>();
  ParticipantService participantService=Get.find<ParticipantService>();

  RxBool isWsConnected = false.obs;
  IOWebSocketChannel? channel;

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
    });
  }

  Future<void> _connect() async {
    //print('Function called from: ${StackTrace.current}');
    String accessToken = await authController.getAccessToken();
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };

    try {
      final webSocket =
          await WebSocket.connect(Url.websocket, headers: headers);
      channel = IOWebSocketChannel(webSocket);
      isWsConnected.value = true;
      channel?.stream.listen(
        (message) {
          handleMessage(message);
        },
        onError: (error) {
          print("WebSocket: Error occurred: $error");
        },
        onDone: () {
          print("WebSocket: Connection closed.");
          isWsConnected.value = false;
        },
      );
      // syncDataAfterConnection();
    } catch (e) {
      print("WebSocket connection failed: $e");
      isWsConnected.value = false;
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

  void handleMessage(dynamic message) async {
    final jsonData = jsonDecode(message);
    print(jsonData);
    var data = jsonData["data"];
    switch (WsMessageResponseType.fromString(jsonData['type'])) {
      case WsMessageResponseType.USER_FOUND:
        if (message != null) {
          PersonModel personModel = PersonModel.fromJson(data);
          personService.fetchPerson(personModel);
        }
        break;
      case WsMessageResponseType.MESSAGE_SEND:
        Message message = Message.fromJson(data);
        messageService.updateMessage(
            int.parse(jsonData["requestId"].toString()), message);
        break;
      case WsMessageResponseType.NEW_MESSAGE:
        Message messageModel = Message.fromJson(data);
        await messageService.saveMessage(messageModel);
        break;
      case WsMessageResponseType.GROUP_CREATED:
        GroupModel groupModel = GroupModel.fromJson(data);
        collectivityService.saveGroup(groupModel);
        participantService.addParticipants(data);
        break;
      case WsMessageResponseType.NEW_GROUP:
        GroupModel groupModel = GroupModel.fromJson(data);
        await collectivityService.saveGroup(groupModel);
        participantService.addParticipants(data);
        break;
      case WsMessageResponseType.DYAD_CREATED:
        DyadModel dyadModel = DyadModel.fromJson(data);
        await collectivityService.fetchDyad(
            dyadModel, int.parse(jsonData["requestId"].toString()));
        break;

      case WsMessageResponseType.NEW_DYAD:
        DyadModel dyadModel = DyadModel.fromJson(data);
        await collectivityService.saveDyad(dyadModel);
        personRepository.createPersonIfNotExist(dyadModel.userId);
        break;

      default:
    }
  }
}
