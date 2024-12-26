import 'dart:io';

import 'package:chat_app/models/group.dart';
import 'package:chat_app/models/groupParticipant.dart';
import 'package:chat_app/models/sourceEnum.dart';
import 'package:chat_app/services/group/CreateGroup.dart';
import 'package:chat_app/services/websocket/WebsocketMessage.dart';
import 'package:chat_app/services/websocket/websocket.dart';
import 'package:chat_app/services/websocket/wsMessageType.dart';
import 'package:get/get.dart';

import '../database/database.dart';

class GroupService extends GetxService {
  static WebSocketClient webSocketClient = Get.find<WebSocketClient>();

  static Future<int> createDirectGroup(
      String? name, String participantId) async {
    GroupModel groupModel =
        GroupModel(isDirectGroup: 1, name: name);
    int id = await DatabaseManager.insertGroup(groupModel);
    GroupParticipantModel groupParticipantModel = GroupParticipantModel(
        groupId: id, participantId: participantId, isSynced: 0);
    DatabaseManager.insertGroupParticipant(groupParticipantModel.toDb());
    if (webSocketClient.isWsConnected.value) {
      WebsocketMessage message = WebsocketMessage(WsMessageType.CREATE_GROUP,
          id.toString(), CreateGroup(null, true, [participantId]));
      webSocketClient.sendWebsocketMessage(message);
    }
    return id;
  }

  static Future<void> updateGroup(GroupModel groupModel, int reqId) async {
    await DatabaseManager.updateGroup(groupModel, reqId);
  }

  static Future<void> saveGroup(GroupModel groupModel) async {
    await DatabaseManager.insertGroup(groupModel);
  }

  static void wsGetGroups() {
    webSocketClient.sendWebsocketMessage(
        WebsocketMessage(WsMessageType.GET_GROUPS, null, null));
  }
}
