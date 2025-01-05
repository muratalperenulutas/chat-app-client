import 'package:chat_app/core/models/JsonSerializable.dart';

class CreateGroup extends JsonSerializable {
  late String? name;
  late bool isDirectGroup;
  late List<String> members;

  CreateGroup(this.name, this.isDirectGroup, this.members);

  void setName(String name) {
    this.name = name;
  }

  @override
  Map<String, dynamic> toJson() {
    return {"name": name, "isDirectGroup": isDirectGroup, "members": members};
  }
}
