import 'package:chat_app/core/models/JsonSerializable.dart';

class CreateGroup extends JsonSerializable {
  late String? name;
  late List<String> members;

  CreateGroup(this.name, this.members);

  void setName(String name) {
    this.name = name;
  }

  @override
  Map<String, dynamic> toJson() {
    return {"name": name, "members": members};
  }
}
