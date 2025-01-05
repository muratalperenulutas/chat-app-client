import 'package:chat_app/data/group/group_service.dart';
import 'package:chat_app/data/message/message.dart';
import 'package:chat_app/data/message/message_repository.dart';
import 'package:chat_app/data/message/message_service.dart';
import 'package:chat_app/core/general_change_notifier.dart';
import 'package:get/get.dart';

class MessageController extends GetxController{
  RxInt localGroupId=0.obs;
  RxList<MessageModel> messages=<MessageModel>[].obs;

  MessageService messageService=Get.find<MessageService>();
  MessageRepository messageRepository=Get.find<MessageRepository>();
  GroupService groupService=Get.find<GroupService>();
  GeneralChangeNotifier generalChangeNotifier=Get.find<GeneralChangeNotifier>();

  @override
  void onInit() {
    super.onInit();
    ever(generalChangeNotifier.isMessagesChanged, (_){
      print("object");
      _loadData();
    });
    ever(localGroupId, (_){
      _loadData();
    });
  }

  void _loadData()async{
    messages.value=await messageRepository.getMessagesFromGroupById(localGroupId.value);
  }

  void sendMessage(String message,int? localGroupId,String? personId,Function setId) async{
    if (message.isNotEmpty) {
      if (localGroupId == null) {
        int id = await groupService.createDirectGroup(
            null, personId??"");
        setId(id);
        localGroupId=id;
      }
      messageService.sendMessageToGroup(message, localGroupId);
    }
  }
  void setLocalGroupId(int id){
    localGroupId.value=id;
  }
}