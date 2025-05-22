import 'package:chat_app/constants/enums/status.dart';
import 'package:chat_app/data/collectivity/collectivity_repository.dart';
import 'package:chat_app/data/collectivity/dyad.dart';
import 'package:chat_app/data/message/message_repository.dart';
import 'package:chat_app/features/chat/controllers/message_controller.dart';
import 'package:get/get.dart';
import '../person/person_repository.dart';
import 'group.dart';

class CollectivityService extends GetxService {
  final CollectivityRepository collectivityRepository =
      Get.find<CollectivityRepository>();
  final MessageRepository messageRepository=Get.find<MessageRepository>();
  final MessageController messageController=Get.find<MessageController>();
  PersonRepository personRepository = Get.find<PersonRepository>();

  Future<void> updateGroup(Group group, int reqId) async {
    await collectivityRepository.updateGroup(group, reqId);
  }

  Future<void> saveGroup(Group group) async {
    await collectivityRepository.insertGroup(group);
  }

  Future<void> saveGroupList(List<Map<String, dynamic>> json) async {
  List<Group> groups=[];
  for(Map<String,dynamic> groupj in json){
    Group group=Group.fromJson(groupj);
    groups.add(group);
  }
  await collectivityRepository.insertGroupList(groups);
  }

  Future<void> syncDyadList(List<Map<String, dynamic>> dtos) async {
    List<Dyad> dyadModels=[];
    for(Map<String,dynamic> dyadj in dtos){
      Dyad dyad=Dyad.fromJson(dyadj);
      dyadModels.add(dyad);
      personRepository.createPersonIfNotExist(dyad.userId);
    }
    await collectivityRepository.insertDyadList(dyadModels);
  }
  Future<void> saveDyad(Dyad dyad) async {
    await collectivityRepository.insertDyad(dyad);
    personRepository.createPersonIfNotExist(dyad.userId);
  }

    Future<void> fetchDyad(Dyad dyad) async {
    await collectivityRepository.updateDyad(dyad);
    messageRepository.batchFixCollectivityIdJob(dyad.collectivityId??"", dyad.userId);
    if(messageController.userId.value==dyad.userId){
     if(dyad.collectivityId!=null) {
       messageController.collectivityId.value = dyad.collectivityId!;
     }
   }
  }
  Future<void> createDyadIfNotExist(String userId)async {
    Dyad? dyad=await collectivityRepository.getDyadByUserId(userId);
    if(dyad==null){
      Dyad dyadModel=Dyad(userId: userId,status: Status.CREATED);
      await collectivityRepository.insertDyad(dyadModel);
    }
  }
}
