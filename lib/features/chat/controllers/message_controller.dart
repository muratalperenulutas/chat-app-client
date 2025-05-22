import 'package:chat_app/data/collectivity/collectivity_service.dart';
import 'package:chat_app/data/message/message.dart';
import 'package:chat_app/data/message/message_repository.dart';
import 'package:chat_app/data/message/message_service.dart';
import 'package:chat_app/core/general_change_notifier.dart';
import 'package:chat_app/features/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  RxString collectivityId="".obs;
  RxString userId="".obs;
  RxList<Message> messages = <Message>[].obs;

  MessageService messageService = Get.find<MessageService>();
  MessageRepository messageRepository = Get.find<MessageRepository>();
  GeneralChangeNotifier generalChangeNotifier =
      Get.find<GeneralChangeNotifier>();
  AuthController authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    everAll([generalChangeNotifier.isMessagesChanged,collectivityId,userId], (_) {
      print("message controller");
      _loadData();
    });
  }

  void _loadData() async {
    messages.value =await messageRepository.
    getMessagesByCollectivityIdOrDyadReceiverId(collectivityId.value,userId.value);
  }

  Future<void> sendMessage(
      String message, String? collectivityId,String? userId ) async {
    if (message.isNotEmpty) {
      if (collectivityId != null) {
        messageService.sendMessageByCollectivityId(message, collectivityId);
      }else if(userId!=null){
        CollectivityService collectivityService = Get.find<CollectivityService>();
        collectivityService.createDyadIfNotExist(userId);
        messageService.sendMessageByReceiverId(message, userId);
      }else{
        throw Error();
      }
    }
  }

  void setCollectivityId(String id) {
    collectivityId.value = id;
  }
  void setUserId(String id) {
    userId.value = id;
  }
}