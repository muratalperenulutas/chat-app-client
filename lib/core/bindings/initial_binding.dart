import 'package:chat_app/core/general_change_notifier.dart';
import 'package:chat_app/core/services/ingest/collectivity_ingest.dart';
import 'package:chat_app/core/services/ingest/contact_ingest.dart';
import 'package:chat_app/core/services/ingest/message_ingest.dart';
import 'package:chat_app/core/services/websocket/websocket_client.dart';
import 'package:chat_app/data/collectivity/collectivity_repository.dart';
import 'package:chat_app/data/collectivity/collectivity_service.dart';
import 'package:chat_app/data/message/message_repository.dart';
import 'package:chat_app/data/message/message_service.dart';
import 'package:chat_app/data/participant/participant_repository.dart';
import 'package:chat_app/data/participant/participant_service.dart';
import 'package:chat_app/data/person/person_repository.dart';
import 'package:chat_app/data/person/person_service.dart';
import 'package:chat_app/features/auth/controllers/auth_controller.dart';
import 'package:chat_app/features/chat/controllers/message_controller.dart';
import 'package:chat_app/features/collectivity/controller/collectivity_controller.dart';
import 'package:chat_app/features/person/controller/person_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GeneralChangeNotifier(), fenix: true);
    Get.put(WebSocketClient(), permanent: true);
    Get.put(AuthController(), permanent: true);

    Get.lazyPut(() => PersonRepository(), fenix: true);
    Get.lazyPut(() => MessageRepository(), fenix: true);
    Get.lazyPut(() => CollectivityRepository(), fenix: true);
    Get.lazyPut(() => ParticipantRepository(), fenix: true);

    Get.lazyPut(() => PersonService(), fenix: true);
    Get.lazyPut(() => MessageService(), fenix: true);
    Get.lazyPut(() => CollectivityService(), fenix: true);
    Get.lazyPut(() => ParticipantService(), fenix: true);

    Get.lazyPut(() => ContactDataIngest(), fenix: true);
    Get.lazyPut(() => MessageDataIngest(), fenix: true);
    Get.lazyPut(() => CollectivityIngest(), fenix: true);


    Get.lazyPut(() => MessageController(), fenix: true);
    Get.lazyPut(() => CollectivityController(), fenix: true);
    Get.lazyPut(() => PersonController(), fenix: true);
  }
}
