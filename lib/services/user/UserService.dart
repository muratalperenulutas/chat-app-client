import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/models/person.dart';
import 'package:chat_app/services/database/database.dart';
import 'package:chat_app/services/user/FindUser.dart';
import 'package:chat_app/services/websocket/WebsocketMessage.dart';
import 'package:chat_app/services/websocket/websocket.dart';
import 'package:chat_app/services/websocket/wsMessageType.dart';
import 'package:get/get.dart';

class UserService extends GetxService {
  static WebSocketClient webSocketClient = Get.find<WebSocketClient>();
  static AuthController authController = Get.find<AuthController>();

  static wsFindUser(String username, int id) {
    FindUser findUser = FindUser(username);
    WebsocketMessage message =
        WebsocketMessage(WsMessageType.FIND_USER, id.toString(), findUser);
    webSocketClient.sendWebsocketMessage(message);
  }

  static fetchUser(PersonModel person) {
    DatabaseManager.fetchPersonFromServer(person);
  }

  static findRegisteredUsers() async {
    List<PersonModel> persons = await DatabaseManager.getContacts();
    for (PersonModel person in persons) {
      wsFindUser(person.username ?? '', person.id ?? 0);
    }
  }
}
