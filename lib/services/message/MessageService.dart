import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/services/database/database.dart';
import 'package:chat_app/services/message/SendMessage.dart';
import 'package:chat_app/services/websocket/WebsocketMessage.dart';
import 'package:chat_app/services/websocket/websocket.dart';
import 'package:chat_app/services/websocket/wsMessageType.dart';
import 'package:get/get.dart';

class MessageService extends GetxService {
  static WebSocketClient webSocketClient = Get.find<WebSocketClient>();
  static AuthController authController = Get.find<AuthController>();

  static Future<void> sendMessage(String messageText, int groupId) async {
    MessageModel message = MessageModel(
        message: messageText,
        groupId: groupId,
        userId: authController.userId.value);
    int id = await DatabaseManager.insertMessage(message);
    if (webSocketClient.isWsConnected.value) {
      WebsocketMessage wsMessage = WebsocketMessage(WsMessageType.SEND_MESSAGE,
          id.toString(), SendMessage(messageText, groupId));
      webSocketClient.sendWebsocketMessage(wsMessage);
    }
  }

  static Future<void> saveMessage(MessageModel messageModel) async {
    await DatabaseManager.insertMessage(messageModel);
  }

  static void updateMessage(int messageId, MessageModel messageModel) {
    DatabaseManager.updateMessage(messageId, messageModel);
  }

  static void wsGetMessages() {
    webSocketClient.sendWebsocketMessage(
        WebsocketMessage(WsMessageType.GET_MESSAGES, null, null));
  }
}
