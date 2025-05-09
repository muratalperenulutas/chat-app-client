import 'package:chat_app/constants/enums/status.dart';

class Message {
  late int? id;
  final int? messageId;
  final String message;
  final int? collectivityId;
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

  factory Message.fromDb(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      messageId: map['messageId'],
      message: map['message'],
      collectivityId: map['collectivityId'],
        dyadReceiverId: map['dyadReceiverId'],
      userId: map['userId'],
      sendTime: DateTime.parse(map['sendTime']),
      status: Status.fromString(map['status'])
    );
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'],
      messageId: json['id'],
        collectivityId: int.parse(json['collectivityId'].toString()),
      userId: json['userId'],
      sendTime: DateTime.fromMillisecondsSinceEpoch(int.parse(json['sendDate'].toString())*1000),
      status: Status.SYNC
    );
  }

  Map<String, dynamic> toJson() {
    return { 
      'message': message,
      'collectivityId': collectivityId.toString(),
    };
  }
  Map<String, dynamic> toDb() {
    return {
      'id': id,
      'messageId': messageId,
      'message': message,
      'collectivityId': collectivityId,
      'dyadReceiverId':dyadReceiverId,
      'userId': userId,
      'sendTime': sendTime.toIso8601String(),
      'status':status.name
    };
  }
  void setId(int id){
    this.id=id;
  }
}
