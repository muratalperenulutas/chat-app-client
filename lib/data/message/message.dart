import 'package:chat_app/constants/enums/status.dart';

class Message {
  late int? id;
  final int? messageId;
  final String message;
  final int? collectivityId;
  final String? dyadReceiverId;
  final String userId;
  final DateTime sendTime;
  final bool? isRead;
  late final Status status;

  Message({
    this.id,
    this.messageId,
    required this.message,
    this.collectivityId,
    this.dyadReceiverId,
    required this.userId,
    required this.sendTime,
    this.isRead,
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
      isRead: map['isRead'],
      status: Status.fromString(map['status'])
    );
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'],
      messageId: json['id'],
        collectivityId: int.parse(json['collectivityId'].toString()),
      userId: json['userId'],
      sendTime: DateTime.parse(json['sendDate'].toString()),
      isRead: json['isRead'],
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
      'isRead': isRead,
      'status':status.name
    };
  }
  void setId(int id){
    this.id=id;
  }
}
