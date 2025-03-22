import 'package:chat_app/data/participant/participant.dart';
import 'package:chat_app/data/participant/participant_repository.dart';
import 'package:chat_app/data/person/person_repository.dart';
import 'package:get/get.dart';

class ParticipantService extends GetxService {
  final PersonRepository personRepository=Get.find<PersonRepository>();
  ParticipantRepository participantRepository=Get.find<ParticipantRepository>();

  Future<void> addParticipants(Map<String, dynamic> json) async {
    List<Participant> participants=Participant.fromJson(json);
    participantRepository.insertParticipantList(participants);
  }
}
