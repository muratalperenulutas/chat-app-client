import 'package:chat_app/constants/enums/status.dart';
import 'package:chat_app/data/collectivity/collectivity_repository.dart';
import 'package:chat_app/data/collectivity/dyad.dart';
import 'package:chat_app/data/message/message_repository.dart';
import 'package:chat_app/features/chat/controllers/message_controller.dart';
import 'package:get/get.dart';
import 'group.dart';

class CollectivityService extends GetxService {
  final CollectivityRepository collectivityRepository =
      Get.find<CollectivityRepository>();
  final MessageRepository messageRepository=Get.find<MessageRepository>();
  final MessageController messageController=Get.find<MessageController>();

  Future<void> updateGroup(GroupModel groupModel, int reqId) async {
    await collectivityRepository.updateGroup(groupModel, reqId);
  }

  Future<void> saveGroup(GroupModel groupModel) async {
    await collectivityRepository.insertGroup(groupModel);
  }
  Future<void> saveDyad(DyadModel dyad) async {
    await collectivityRepository.insertDyad(dyad);
  }
  Future<void> fetchDyad(DyadModel dyad,int id) async {
    dyad.setId(id);//find by userId not request id
    await collectivityRepository.updateDyad(dyad,id);
   messageRepository.batchFixCollectivityIdJob(dyad.collectivityId??0, dyad.userId);
   if(messageController.userId.value==dyad.userId){
     if(dyad.collectivityId!=null) {
       messageController.collectivityId.value = dyad.collectivityId!;
     }
   }
  }
  Future<void> createDyadIfNotExist(String userId)async {
    DyadModel? dyad=await collectivityRepository.getDyadByUserId(userId);
    if(dyad==null){
      DyadModel dyadModel=DyadModel(userId: userId,status: Status.CREATED);
      await collectivityRepository.insertDyad(dyadModel);
    }
  }
}
