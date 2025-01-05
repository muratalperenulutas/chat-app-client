import 'package:chat_app/constants/enums/source_enum.dart';

class MessageModel {
  late int? id;
  final int? messageId;
  final String message;
  final int? groupId;
  final int? localGroupId;
  final String userId;
  final DateTime? syncTime;
  final bool? isRead;
  final bool? isSynced;

  MessageModel({
    this.id,
    this.messageId,
    this.localGroupId,
    required this.message,
    this.groupId,
    required this.userId,
    this.syncTime,
    this.isRead,
    this.isSynced
  });

  factory MessageModel.fromDb(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'],
      messageId: map['messageId'],
      localGroupId: map['localGroupId'],
      message: map['message'],
      groupId: map['groupId'],
      userId: map['userId'],
      syncTime: map['syncTime'],
      isRead: map['isRead']
    );
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'],
      messageId: json['id'],
      groupId: int.parse(json['groupId']),
      userId: json['userId'],
      syncTime: json['syncTime'],
      isRead: json['isRead']
    );
  }

  Map<String, dynamic> toJson() {
    return { 
      'message': message,
      'groupId': groupId.toString(),
    };
  }
  Map<String, dynamic> toDb() {
    return {
      'id': id,
      'messageId': messageId,
      'message': message,
      'localGroupId':localGroupId,
      'groupId': groupId,
      'userId': userId,
      'syncTime': syncTime?.toIso8601String(),
      'isRead': isRead,
      'isSynced': isSynced
    };
  }
  void setId(int id){
    this.id=id;
  }
}
