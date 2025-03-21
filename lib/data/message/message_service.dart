import 'package:chat_app/constants/enums/status.dart';
import 'package:chat_app/data/message/message_repository.dart';
import 'package:chat_app/features/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'message.dart';

class MessageService extends GetxService {
  final AuthController authController = Get.find<AuthController>();
  final MessageRepository messageRepository=Get.find<MessageRepository>();

  Future<void> sendMessageByCollectivityId(String messageText, int collectivityId) async {
    Message message = Message(
        message: messageText,
        collectivityId: collectivityId,
        userId: authController.myId.value,
        sendTime: DateTime.now(),
      status: Status.CREATED
        );
    await messageRepository.insertMessage(message);
  }

  Future<void> sendMessageByReceiverId(String messageText,String receiverId ) async {
    Message message = Message(
        message: messageText,
        dyadReceiverId: receiverId,
        userId: authController.myId.value,
        sendTime: DateTime.now(),
        status: Status.CREATED
    );
    await messageRepository.insertMessage(message);
  }

  Future<void> saveMessage(Message message) async {
    await messageRepository.insertMessage(message);
  }

  void updateMessage(int messageId, Message message) {
    message.setId(messageId);
    messageRepository.updateMessage(messageId, message);
  }
}
