import 'package:chat_app/constants/enums/status.dart';
import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/data/collectivity/collectivity_repository.dart';
import 'package:chat_app/data/collectivity/dyad.dart';
import 'package:chat_app/data/message/message_repository.dart';
import 'package:chat_app/features/auth/controllers/auth_controller.dart';
import 'package:chat_app/features/chat/controllers/message_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../person/person_repository.dart';
import 'group.dart';

class CollectivityService {
  final ProviderContainer ref;
  final CollectivityRepository collectivityRepository = getIt<CollectivityRepository>();
  final MessageRepository messageRepository = getIt<MessageRepository>();
  final PersonRepository personRepository = getIt<PersonRepository>();

  CollectivityService(this.ref);

  Future<void> updateGroup(Group group) async {
    await collectivityRepository.updateGroup(group);
  }

  Future<void> saveGroup(Group group) async {
    await collectivityRepository.insert(group);
  }

  Future<void> saveGroupList(List<Map<String, dynamic>> json) async {
  List<Group> groups=[];
  for(Map<String,dynamic> groupj in json){
    Group group=Group.fromJson(groupj);
    groups.add(group);
  }
  await collectivityRepository.insertCollectivityList(groups);
  }

  Future<void> syncDyadList(List<Map<String, dynamic>> dtos) async {
    final myId = ref.read(authControllerProvider).myId;
    List<Dyad> dyadModels=[];
    for(Map<String,dynamic> dyadj in dtos){
      Dyad dyad=Dyad.fromJson(dyadj, myId);
      dyadModels.add(dyad);
      personRepository.createPersonIfNotExist(dyad.userId);
    }
    await collectivityRepository.insertCollectivityList(dyadModels);
  }
  Future<void> saveDyad(Dyad dyad) async {
    await collectivityRepository.insert(dyad);
    personRepository.createPersonIfNotExist(dyad.userId);
  }

    Future<void> fetchDyad(Dyad dyad) async {
    await collectivityRepository.updateDyad(dyad);
    print(dyad.collectivityId);
    if(dyad.collectivityId==null){
      return;
    }
    messageRepository.batchFixCollectivityIdJob(dyad.collectivityId!, dyad.userId);
    
    final messageState = ref.read(messageControllerProvider);
    if(messageState.userId == dyad.userId){
     if(dyad.collectivityId!=null) {
       ref.read(messageControllerProvider.notifier).setCollectivityId(dyad.collectivityId!);
     }
   }
  }
  Future<void> createDyadIfNotExist(String userId)async {
    Dyad? dyad=await collectivityRepository.getDyadByUserId(userId);
    if(dyad==null){
      Dyad dyadModel=Dyad(userId: userId,status: Status.created);
      await collectivityRepository.insert(dyadModel);
    }
  }
}
