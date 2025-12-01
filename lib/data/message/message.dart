import 'package:chat_app/constants/enums/status.dart';

class Message {
  late int? id;
  final String? messageId;
  final String message;
  final String? collectivityId;
  final String? dyadReceiverId;
  final String userId;
  final DateTime sendTime;
  Status status;

  Message({
    this.id,
    this.messageId,
    required this.message,
    this.collectivityId,
    this.dyadReceiverId,
    required this.userId,
    required this.sendTime,
    required this.status
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'],
      messageId: json['messageId'],
        collectivityId: json['collectivityId'].toString(),
      userId: json['userId'],
      sendTime: DateTime.fromMillisecondsSinceEpoch(int.parse(json['sendTime'].toString())*1000),
      status: Status.sync
    );
  }

  Map<String, dynamic> toJson() {
    return { 
      'message': message,
      'collectivityId': collectivityId.toString(),
    };
  }

  void setId(int id){
    this.id=id;
  }
}
