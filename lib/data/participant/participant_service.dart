import 'package:chat_app/data/collectivity/collectivity_repository.dart';
import 'package:chat_app/data/participant/participant.dart';
import 'package:chat_app/data/participant/participant_repository.dart';
import 'package:chat_app/data/person/person_repository.dart';
import 'package:get/get.dart';

class ParticipantService extends GetxService {
  final PersonRepository personRepository=Get.find<PersonRepository>();
  ParticipantRepository participantRepository=Get.find<ParticipantRepository>();
  CollectivityRepository collectivityRepository=Get.find<CollectivityRepository>();

  Future<void> addParticipants(List<Map<String, dynamic>> json) async {
    List<Participant> participants=Participant.fromJsonList(json);
    participantRepository.insertParticipantList(participants);
    initializeReferences(participants);
  }
  void initializeReferences(List<Participant> participants){
    for(Participant participant in participants){
      if(participant.collectivityId!=null||participant.collectivityId!="") {
        collectivityRepository.createCollectivityIfNotExist(
            participant.collectivityId!);
      }
      if(participant.userId!=null||participant.userId!="") {
        personRepository.createPersonIfNotExist(
            participant.userId!);
      }
    }
  }
}
