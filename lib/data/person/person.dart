import 'package:chat_app/constants/enums/status.dart';

class Person {
  final int? id;
  final String? personId;
  final String? name;
  final String? username;
  final String? description;
  final String? imageId;
  Status status;

  Person({
    this.id,
    this.personId,
    this.name,
    this.username,
    this.description,
    this.imageId,
    this.status=Status.created
  });
  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
        personId: json['userId'],
        username: json['username'],
        name: "initial",
        status: Status.sync
        ////
    );
  }
}
