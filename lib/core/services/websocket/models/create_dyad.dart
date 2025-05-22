import 'package:chat_app/core/models/JsonSerializable.dart';

class CreateDyad extends JsonSerializable {
  late String userId;

  CreateDyad(this.userId);

  @override
  Map<String, dynamic> toJson() {
    return {"id": userId};
  }
}
