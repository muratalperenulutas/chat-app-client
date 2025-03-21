import 'dart:convert';
import 'dart:io';
import 'package:chat_app/config/urls.dart';
import 'package:chat_app/core/services/websocket/models/websocket_message.dart';
import 'package:chat_app/data/collectivity/collectivity_service.dart';
import 'package:chat_app/data/collectivity/dyad.dart';
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
  PersonService personService=Get.find<PersonService>();
  MessageService messageService=Get.find<MessageService>();
  CollectivityService collectivityService=Get.find<CollectivityService>();
  PersonRepository personRepository=Get.find<PersonRepository>();

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
    print("send  "+jsonMessage);
  }

  void close() {
    channel?.sink.close();
  }

  void handleMessage(dynamic message) async {
    final jsonData = jsonDecode(message);
    print(jsonData);
    switch (WsMessageResponseType.fromString(jsonData['type'])) {
      case WsMessageResponseType.USER_FOUND:
        var message = jsonData["data"];
        if (message != null) {
          PersonModel personModel = PersonModel.fromJson(message);
          personService.fetchPersonFromServer(personModel);
        }
        break;
      case WsMessageResponseType.MESSAGE_SEND:
        var data = jsonData["data"];
        Message message = Message.fromJson(data);
        messageService.updateMessage(
            int.parse(jsonData["requestId"].toString()), message);
        break;
      case WsMessageResponseType.NEW_MESSAGE:
        var message = jsonData["data"];
          Message messageModel = Message.fromJson(message);
          await messageService.saveMessage(messageModel);
        break;
      case WsMessageResponseType.GROUP_CREATED:
        var group = jsonData["data"];
        GroupModel groupModel = GroupModel.fromJson(group);
        int reqId = jsonData["requestId"];
        collectivityService.updateGroup(groupModel, reqId);
        break;
      case WsMessageResponseType.NEW_GROUP:
        List<dynamic> groups = jsonData["data"];
        for (var group in groups) {
          print("loop");
          GroupModel groupModel = GroupModel.fromJson(group);
          await collectivityService.saveGroup(groupModel);
        }
        break;
      case WsMessageResponseType.DYAD_CREATED:
        var dyad = jsonData["data"];
        DyadModel dyadModel=DyadModel.fromJson(dyad);
        await collectivityService.fetchDyad(dyadModel,int.parse(jsonData["requestId"].toString()));
        break;

       case WsMessageResponseType.NEW_DYAD:
         var dyad = jsonData["data"];
         DyadModel dyadModel = DyadModel.fromJson(dyad);
         await collectivityService.saveDyad(dyadModel);
         personRepository.createPersonIfNotExist(dyadModel.userId);
        break;

      default:
    }
  }
}
