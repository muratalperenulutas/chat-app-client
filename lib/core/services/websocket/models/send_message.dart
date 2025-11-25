import 'package:chat_app/core/models/JsonSerializable.dart';

class SendMessage extends JsonSerializable {
  late String message;
  late String collectivityId;

  SendMessage(this.message, this.collectivityId);

  void setMessage(String message) {
    this.message = message;
  }

  void setCollectivityId(String id) {
    collectivityId = id;
  }

  @override
  Map<String, dynamic> toJson() {
    return {'message': message, 'collectivityId': collectivityId.toString()};
  }
}
