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
    case "get-user-groups":
      String groupCount = jsonData["data"]["groupCount"];
      List<dynamic> groups = jsonData["data"]["groups"];
      for (var groupData in groups) {
        GroupModel groupModel = GroupModel.fromJson(groupData); 
        await DatabaseManager.insertGroup(groupModel);
      }
      break;
    default:
  }
}
