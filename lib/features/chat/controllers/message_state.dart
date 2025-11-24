import 'package:chat_app/data/message/message.dart';

class MessageState {
  final String collectivityId;
  final String userId;
  final List<Message> messages;

  MessageState({
    this.collectivityId = '',
    this.userId = '',
    this.messages = const [],
  });

  MessageState copyWith({
    String? collectivityId,
    String? userId,
    List<Message>? messages,
  }) {
    return MessageState(
      collectivityId: collectivityId ?? this.collectivityId,
      userId: userId ?? this.userId,
      messages: messages ?? this.messages,
    );
  }
}
