import 'dart:async';

import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/core/services/sync/sync.dart';
import 'package:chat_app/data/person/person_repository.dart';
import 'package:chat_app/data/person/person_service.dart';

import '../../../constants/enums/ws_message_type.dart';
import '../../../data/person/person.dart';
import '../websocket/models/find_user.dart';
import '../websocket/models/websocket_message.dart';

class ContactSyncService {
  final PersonService personService = getIt<PersonService>();
  final PersonRepository personRepository = getIt<PersonRepository>();
  final SyncService syncService = getIt<SyncService>();
  
  StreamSubscription<List<Person>>? _unsyncedPersonsSubscription;

  ContactSyncService() {
    _setupAutoSync();
  }

  void _setupAutoSync() {
    _unsyncedPersonsSubscription = personRepository.watchUnsyncedPersons().listen((persons) {
      if (persons.isNotEmpty) {
        _syncPersons(persons);
      }
    });
  }

  void _syncPersons(List<Person> persons) {
    for (Person person in persons) {
      FindUser findUser = FindUser(person.username, person.personId);
      WebsocketMessage message =
          WebsocketMessage(WsMessageType.FIND_USER, person.id.toString(), findUser);
      syncService.sendMessage(message);
    }
  }

  void findRegisteredPersons() async {
    List<Person> persons = await personRepository.getUnscncedPerson();
    _syncPersons(persons);
  }
  
  void dispose() {
    _unsyncedPersonsSubscription?.cancel();
  }
}