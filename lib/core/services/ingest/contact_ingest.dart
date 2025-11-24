import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/core/general_change_notifier.dart';
import 'package:chat_app/core/services/websocket/websocket_client.dart';
import 'package:chat_app/data/person/person_repository.dart';
import 'package:chat_app/data/person/person_service.dart';

import '../../../constants/enums/ws_message_type.dart';
import '../../../data/person/person.dart';
import '../websocket/models/find_user.dart';
import '../websocket/models/websocket_message.dart';

class ContactDataIngest {
  final GeneralChangeNotifier generalChangeNotifier = getIt<GeneralChangeNotifier>();
  final WebSocketClient webSocketClient = getIt<WebSocketClient>();
  final PersonService personService = getIt<PersonService>();
  final PersonRepository personRepository = getIt<PersonRepository>();

  ContactDataIngest() {
    // TODO: Add reactivity(Auto sync when connectivity is back or on data changes)
  }

  void syncContacts() async {
    if (webSocketClient.isWsConnected) {
      findRegisteredPersons();
    }
  }

  void findRegisteredPersons() async {
    List<Person> persons = await personRepository.getUnscncedPerson();
    for (Person person in persons) {
      FindUser findUser = FindUser(person.username, person.personId);
      WebsocketMessage message =
      WebsocketMessage(WsMessageType.FIND_USER, person.id.toString(), findUser);
      webSocketClient.sendWebsocketMessage(message);
    }
  }
}