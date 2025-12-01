import 'package:chat_app/constants/enums/status.dart';
import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/data/message/message_repository.dart';
import 'package:chat_app/features/auth/controllers/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'message.dart';

class MessageService {
  final ProviderContainer ref;
  final MessageRepository messageRepository = getIt<MessageRepository>();

  MessageService(this.ref);

  Future<void> sendMessageByCollectivityId(String messageText, String collectivityId) async {
    final myId = ref.read(authControllerProvider).myId;
    Message message = Message(
        message: messageText,
        collectivityId: collectivityId,
        userId: myId,
        sendTime: DateTime.now(),
      status: Status.created
        );
    await messageRepository.insertMessage(message);
  }

  Future<void> sendMessageByReceiverId(String messageText,String receiverId ) async {
    final myId = ref.read(authControllerProvider).myId;
    Message message = Message(
        message: messageText,
        dyadReceiverId: receiverId,
        userId: myId,
        sendTime: DateTime.now(),
        status: Status.created
    );
    await messageRepository.insertMessage(message);
  }

  Future<void> saveMessage(Message message) async {
    await messageRepository.insertMessage(message);
  }
  Future<void> syncMessages(List<Map<String, dynamic>> json) async {
    List<Message> messages=[];
    for(Map<String,dynamic> dyad in json){
      Message message=Message.fromJson(dyad);
      messages.add(message);
    }
    await messageRepository.insertMessageList(messages);
  }

  void updateMessage(int messageId, Message message) {
    message.setId(messageId);
    messageRepository.updateMessage(message);
  }
}
