import 'dart:convert';

import 'package:chat_app/models/group.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/models/person.dart';
import 'package:chat_app/services/database/database.dart';
import 'package:chat_app/services/group/GroupService.dart';
import 'package:chat_app/services/message/MessageService.dart';
import 'package:chat_app/services/user/UserService.dart';
import 'package:chat_app/services/websocket/wsMessageResponseType.dart';

void handleMessage(dynamic message) async {
  final jsonData = jsonDecode(message);
  print(jsonData);
  switch (WsMessageResponseType.fromString(jsonData['command'])) {
    case WsMessageResponseType.FIND_USER_RESPONSE:
      print("find user response");
      var message = jsonData["data"];
      if (message != null) {
        PersonModel personModel = PersonModel.fromJson(message);
        UserService.fetchUser(personModel);
      }
      break;
    case WsMessageResponseType.SEND_MESSAGE_RESPONSE:
      print("send message response");
      var message = jsonData["data"];
      MessageModel messageModel = MessageModel.fromJson(message);
      messageModel.setId(int.parse(jsonData["requestId"]));
      MessageService.updateMessage(
          int.parse(jsonData["requestId"]), messageModel);
      break;
    case WsMessageResponseType.GET_MESSAGES_RESPONSE:
      print("get messages response");
      var messages = jsonData["data"];
      for (var message in messages) {
        print("loop");
        MessageModel messageModel = MessageModel.fromJson(message);
        await MessageService.saveMessage(messageModel);
      }
      break;
    case WsMessageResponseType.CREATE_GROUP_RESPONSE:
      print("create group response");
      var group = jsonData["data"];
      GroupModel groupModel = GroupModel.fromJson(group);
      int reqId = jsonData["requestId"];
      GroupService.updateGroup(groupModel, reqId);
      break;
    case WsMessageResponseType.GET_GROUPS_RESPONSE:
      print("get group response");
      List<dynamic> groups = jsonData["data"];
      for (var group in groups) {
        print("loop");
        GroupModel groupModel = GroupModel.fromJson(group);
        await GroupService.saveGroup(groupModel);
      }
      break;
    default:
  }
}
