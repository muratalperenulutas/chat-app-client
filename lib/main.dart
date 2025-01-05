import 'package:chat_app/app.dart';
import 'package:chat_app/data/database_service.dart';
import 'package:chat_app/data/group/group_repository.dart';
import 'package:chat_app/data/group/group_service.dart';
import 'package:chat_app/data/group_participant/group_participant_repository.dart';
import 'package:chat_app/data/message/message_repository.dart';
import 'package:chat_app/data/message/message_service.dart';
import 'package:chat_app/data/person/person_repository.dart';
import 'package:chat_app/data/person/person_service.dart';
import 'package:chat_app/features/chat/controllers/message_controller.dart';
import 'package:chat_app/features/chat/services/chat_page_service.dart';
import 'package:chat_app/core/general_change_notifier.dart';
import 'package:chat_app/features/person/controller/person_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/services/websocket/websocket_client.dart';
import 'features/auth/controllers/auth_controller.dart';
import 'features/group/controller/group_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseService=DatabaseService();
  await databaseService.onInit();
  Get.put<DatabaseService>(databaseService);

  Get.lazyPut(()=>GeneralChangeNotifier());
  Get.put(AuthController());
  Get.put(PersonRepository());
  Get.put(PersonService());
  Get.put(MessageRepository());
  Get.put(MessageService());
  Get.put(GroupRepository());
  Get.put(GroupParticipantRepository());
  Get.put(GroupService());
  Get.put(GroupController());
  Get.put(PersonController());
  Get.put(ChatPageService());

  Get.put(WebSocketClient());

  runApp(MyApp());
}
