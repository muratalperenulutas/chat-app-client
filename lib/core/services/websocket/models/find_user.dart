import 'package:chat_app/core/models/JsonSerializable.dart';

class FindUser extends JsonSerializable {
  late String? username;
  late String? userId;


  FindUser(this.username,this.userId);


  @override
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      "userId":userId
    };
  }
}
