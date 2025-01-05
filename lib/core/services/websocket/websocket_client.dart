import 'dart:convert';
import 'dart:io';
import 'package:chat_app/config/urls.dart';
import 'package:chat_app/core/services/websocket/models/websocket_message.dart';
import 'package:chat_app/data/person/person_repository.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';

import '../../../constants/enums/ws_message_response_type.dart';
import '../../../constants/enums/ws_message_type.dart';
import '../../../data/group/group.dart';
import '../../../data/group/group_service.dart';
import '../../../data/message/message.dart';
import '../../../data/message/message_service.dart';
import '../../../data/person/person.dart';
import '../../../data/person/person_service.dart';
import '../../../features/auth/controllers/auth_controller.dart';
import 'models/create_group.dart';
import 'models/find_user.dart';

class WebSocketClient extends GetxService {
  AuthController authController = Get.find<AuthController>();
  PersonService personService=Get.find<PersonService>();
  MessageService messageService=Get.find<MessageService>();
  GroupService groupService=Get.find<GroupService>();
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
      syncDataAfterConnection();
    } catch (e) {
      print("WebSocket connection failed: $e");
      isWsConnected.value = false;
    }
  }

  void sendWebsocketMessage(WebsocketMessage message) {
    String jsonMessage = jsonEncode(message.toJson());
    channel?.sink.add(jsonMessage);
    print("s");
  }

  void close() {
    channel?.sink.close();
  }

  void handleMessage(dynamic message) async {
    final jsonData = jsonDecode(message);
    print(jsonData);
    switch (WsMessageResponseType.fromString(jsonData['command'])) {
      case WsMessageResponseType.FIND_USER_RESPONSE:
        print("find user response");
        var message = jsonData["data"];
        if (message != null) {
          PersonModel personModel = PersonModel.fromJson(message);
          personService.fetchPersonFromServer(personModel);
        }
        break;
      case WsMessageResponseType.SEND_MESSAGE_RESPONSE:
        print("send message response");
        var message = jsonData["data"];
        MessageModel messageModel = MessageModel.fromJson(message);
        messageModel.setId(int.parse(jsonData["requestId"]));
        messageService.updateMessage(
            int.parse(jsonData["requestId"]), messageModel);
        break;
      case WsMessageResponseType.GET_MESSAGES_RESPONSE:
        print("get messages response");
        var messages = jsonData["data"];
        for (var message in messages) {
          print("loop");
          MessageModel messageModel = MessageModel.fromJson(message);
          await messageService.saveMessage(messageModel);
        }
        break;
      case WsMessageResponseType.CREATE_GROUP_RESPONSE:
        print("create group response");
        var group = jsonData["data"];
        GroupModel groupModel = GroupModel.fromJson(group);
        int reqId = jsonData["requestId"];
        groupService.updateGroup(groupModel, reqId);
        break;
      case WsMessageResponseType.GET_GROUPS_RESPONSE:
        print("get group response");
        List<dynamic> groups = jsonData["data"];
        for (var group in groups) {
          print("loop");
          GroupModel groupModel = GroupModel.fromJson(group);
          await groupService.saveGroup(groupModel);
        }
        break;
      default:
    }
  }

  void syncDataAfterConnection(){
    if (isWsConnected.value) {
      getGroups();
      getMessages();
      findRegisteredContacts();
    }
  }
  void getGroups() {
    sendWebsocketMessage(
        WebsocketMessage(WsMessageType.GET_GROUPS, null, null));
  }
  void createGroup(int id,List<String> members){
    WebsocketMessage message = WebsocketMessage(WsMessageType.CREATE_GROUP,
        id.toString(), CreateGroup(null, true, members));
    sendWebsocketMessage(message);
  }

  void getMessages() {
    sendWebsocketMessage(
        WebsocketMessage(WsMessageType.GET_MESSAGES, null, null));
  }
  wsFindUser(String username, int id) {
    FindUser findUser = FindUser(username);
    WebsocketMessage message =
    WebsocketMessage(WsMessageType.FIND_USER, id.toString(), findUser);
    sendWebsocketMessage(message);
  }

  void findRegisteredContacts() async {
    List<PersonModel> persons = await personRepository.getContacts();
    for (PersonModel person in persons) {
      wsFindUser(person.username ?? '', person.id ?? 0);
    }

  }
}
