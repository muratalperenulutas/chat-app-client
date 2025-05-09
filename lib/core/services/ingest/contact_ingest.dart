
import 'package:chat_app/core/general_change_notifier.dart';
import 'package:chat_app/core/services/websocket/websocket_client.dart';
import 'package:chat_app/data/person/person_repository.dart';
import 'package:chat_app/data/person/person_service.dart';
import 'package:get/get.dart';

import '../../../constants/enums/ws_message_type.dart';
import '../../../data/person/person.dart';
import '../websocket/models/find_user.dart';
import '../websocket/models/websocket_message.dart';

class ContactDataIngest extends GetxService{
  final GeneralChangeNotifier generalChangeNotifier=Get.find<GeneralChangeNotifier>();
  final WebSocketClient webSocketClient=Get.find<WebSocketClient>();
  final PersonService personService=Get.find<PersonService>();
  final PersonRepository personRepository=Get.find<PersonRepository>();

  ContactDataIngest(){
    everAll([generalChangeNotifier.isContactsChanged,webSocketClient.isWsConnected], (count) async {
      if(webSocketClient.isWsConnected.value) {
        findRegisteredPersons();
      }
    });
  }
  void findRegisteredPersons() async {
    personRepository.printAll();
    List<PersonModel> persons = await personRepository.getUnscncedPerson();
    for (PersonModel person in persons) {
      FindUser findUser = FindUser(person.username,person.personId);
      WebsocketMessage message =
      WebsocketMessage(WsMessageType.FIND_USER, person.id.toString(), findUser);
      webSocketClient.sendWebsocketMessage(message);
    }
  }
}