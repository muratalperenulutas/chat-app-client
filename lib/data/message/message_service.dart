import 'package:chat_app/data/message/message_repository.dart';
import 'package:chat_app/features/auth/controllers/auth_controller.dart';
import 'package:chat_app/core/services/websocket/models/send_message.dart';
import 'package:chat_app/core/services/websocket/models/websocket_message.dart';
import 'package:chat_app/core/services/websocket/websocket_client.dart';
import 'package:chat_app/constants/enums/ws_message_type.dart';
import 'package:get/get.dart';
import 'message.dart';

class MessageService extends GetxService {
  final AuthController authController = Get.find<AuthController>();
  final MessageRepository messageRepository=Get.find<MessageRepository>();

  Future<void> sendMessageToGroup(String messageText, int localGroupId) async {
    MessageModel message = MessageModel(
        message: messageText,
        localGroupId: localGroupId,
        userId: authController.userId.value);
    await messageRepository.insertMessage(message);
  }

  Future<void> saveMessage(MessageModel messageModel) async {
    await messageRepository.insertMessage(messageModel);
  }

  void updateMessage(int messageId, MessageModel messageModel) {
    messageRepository.updateMessage(messageId, messageModel);
  }
}
