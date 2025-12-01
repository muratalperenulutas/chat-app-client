import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/data/collectivity/collectivity_repository.dart';
import 'package:chat_app/data/participant/participant.dart';
import 'package:chat_app/data/participant/participant_repository.dart';
import 'package:chat_app/data/person/person_repository.dart';

class ParticipantService {
  final PersonRepository personRepository = getIt<PersonRepository>();
  final ParticipantRepository participantRepository = getIt<ParticipantRepository>();
  final CollectivityRepository collectivityRepository = getIt<CollectivityRepository>();

  ParticipantService();

  Future<void> addParticipants(List<Map<String, dynamic>> json) async {
    List<Participant> participants = Participant.fromJsonList(json);
    participantRepository.insertParticipantList(participants);
    initializeReferences(participants);
  }

  void initializeReferences(List<Participant> participants) {
    for (Participant participant in participants) {
      if (participant.collectivityId != null && participant.collectivityId != "") {
        collectivityRepository.createCollectivityIfNotExist(participant.collectivityId!);
      }
      if (participant.userId != null && participant.userId != "") {
        personRepository.createPersonIfNotExist(participant.userId!);
      }
    }
  }
}
