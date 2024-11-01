class MessageModel {
  final String message;
  final String? id;
  final String? messageId;
  final String groupId;
  final String senderId;
  final DateTime? sendTime;

  const MessageModel({
    required this.message,
    this.id,
    this.messageId,
    required this.groupId,
    required this.senderId,
    required this.sendTime,
  });

  factory MessageModel.fromDb(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'],
      id: map['id'].toString(),
      messageId: map['messageId'].toString(),
      groupId: map['groupId'].toString(),
      senderId: map['senderId'].toString(),
      sendTime: map['sendTime'],
    );
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'],
      messageId: json['messageId'],
      groupId: json['groupId'],
      senderId: json['senderId'],
      sendTime: json['sendTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return { 
      'message': message,
      'messageId': messageId,
      'groupId': groupId,
      'senderId': senderId,
      'sendTime': sendTime,
    };
  }
}
