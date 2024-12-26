import 'package:chat_app/models/ToJson.dart';

class SendMessage extends JsonSerializable {
  late String message;
  late int groupId;

  SendMessage(this.message, this.groupId);

  void setMessage(String message) {
    this.message = message;
  }

  void setGroupId(int groupId) {
    this.groupId = groupId;
  }

  @override
  Map<String, dynamic> toJson() {
    return {'message': message, 'groupId': groupId.toString()};
  }
}
