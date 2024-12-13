import 'package:chat_app/models/personOriginType.dart';

class PersonModel {
  final int? id;
  final String? personId;
  final String name;
  final String? username;
  final String? identifier;
  final String? description;
  final String? imageId;
  final String type;
  final int? isRegistered;
  final int? isSynced;

  const PersonModel({
    this.id,
    this.personId,
    required this.name,
    this.username,
    this.identifier,
    this.description,
    this.imageId,
    required this.type,
    this.isRegistered,
    this.isSynced
  });
  factory PersonModel.fromDb(Map<String, dynamic> map) {
    return PersonModel(
      id: map['id'],
      personId: map['personId'],
      name: map['name'],
      username: map['username'],
      identifier: map['identifier'],
      description:map['description'],
      imageId: map['imageId'],
      type: map['type'],
      isRegistered: map['isRegistered'],
      isSynced: map['isSynced']
    );
  }
  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
        personId: json['id'],
        name: json['name'],
        username: json['ownerId'],
        type:PersonOriginType.server.toString()
        ////
    );
  }
  Map<String,dynamic> toDb() => {
    'id': id,
    'personId':personId,
    'name': name,
    'username':username,
    'identifier':identifier,
    'description':description,
    'imageId':imageId,
    'type':type,
    'isRegistered':isRegistered,
    'isSynced':isSynced
  };
}
