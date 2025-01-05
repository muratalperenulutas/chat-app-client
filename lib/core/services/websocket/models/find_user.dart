import 'package:chat_app/core/models/JsonSerializable.dart';

class FindUser extends JsonSerializable {
  late String username;

  FindUser(this.username);

  void setUsername(String identifier) {
    this.username = identifier;
  }

  @override
  Map<String, dynamic> toJson() {
    return {'username': username};
  }
}
