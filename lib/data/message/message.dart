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

  factory Message.fromDb(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      messageId: map['message_id'],
      message: map['message'],
      collectivityId: map['collectivity_id'],
      dyadReceiverId: map['dyad_receiver_id'],
      userId: map['user_id'],
      sendTime: map['send_time'] != null ? DateTime.fromMillisecondsSinceEpoch(map['send_time']) : DateTime.now(),
      status: Status.fromString(map['status'])
    );
  }

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
  Map<String, dynamic> toDb() {
    return {
      'id': id,
      'message_id': messageId,
      'message': message,
      'collectivity_id': collectivityId,
      'dyad_receiver_id': dyadReceiverId,
      'user_id': userId,
      'send_time': sendTime.millisecondsSinceEpoch,
      'status': status.name
    };
  }
  void setId(int id){
    this.id=id;
  }
}
