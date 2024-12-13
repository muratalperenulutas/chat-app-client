import 'dart:convert';

import 'package:chat_app/models/group.dart';
import 'package:chat_app/services/database/database.dart';

void handleMessage(dynamic message) async {
  final jsonData = jsonDecode(message);
  print(jsonData);
  switch (jsonData['command']) {
    case "send-message":
      break;
    case "receive-message":
      break;
    case "GET_GROUPS_RESPONSE":
      print("get group response");
      List<dynamic> groups = jsonData["data"];
      for (var group in groups) {
        print("loop");
        GroupModel groupModel = GroupModel.fromJson(group);
        await DatabaseManager.insertGroup(groupModel);
      }
      break;
    default:
  }
}
