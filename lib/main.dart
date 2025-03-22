import 'package:chat_app/app.dart';
import 'package:chat_app/core/services/ingest/contact_ingest.dart';
import 'package:chat_app/core/services/ingest/collectivity_ingest.dart';
import 'package:chat_app/core/services/ingest/message_ingest.dart';
import 'package:chat_app/data/collectivity/collectivity_repository.dart';
import 'package:chat_app/data/collectivity/collectivity_service.dart';
import 'package:chat_app/data/database_service.dart';
import 'package:chat_app/data/message/message_repository.dart';
import 'package:chat_app/data/message/message_service.dart';
import 'package:chat_app/data/participant/participant_service.dart';
import 'package:chat_app/data/person/person_repository.dart';
import 'package:chat_app/data/person/person_service.dart';
import 'package:chat_app/core/general_change_notifier.dart';
import 'package:chat_app/features/chat/controllers/message_controller.dart';
import 'package:chat_app/features/collectivity/controller/collectivity_controller.dart';
import 'package:chat_app/features/person/controller/person_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/services/websocket/websocket_client.dart';
import 'data/participant/participant_repository.dart';
import 'features/auth/controllers/auth_controller.dart';

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
  Get.put(CollectivityRepository());
  Get.put(ParticipantRepository());
  Get.put(MessageController());
  Get.put(CollectivityService());
  Get.put(CollectivityController());
  Get.put(PersonController());
  Get.put(ParticipantService());
  Get.put(WebSocketClient());
  Get.put(ContactDataIngest());
  Get.put(MessageDataIngest());
  Get.put(CollectivityIngest());

  runApp(MyApp());
}
