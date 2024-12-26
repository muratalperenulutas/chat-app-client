import 'package:chat_app/models/sourceEnum.dart';

class PersonModel {
  final int? id;
  final String? personId;
  final String? name;
  final String? localName;
  final String? username;
  final String? description;
  final String? imageId;
  final SourceEnum source;
  final int? isRegistered;
  final int? isSynced;

  PersonModel({
    this.id,
    this.personId,
    this.name,
    this.username,
    this.localName,
    this.description,
    this.imageId,
    required this.source,
    this.isRegistered,
    this.isSynced
  });
  factory PersonModel.fromDb(Map<String, dynamic> map) {
    return PersonModel(
      id: map['id'],
      personId: map['personId'],
      name: map['name'],
      username: map['username'],
      localName: map['localName'],
      description:map['description'],
      imageId: map['imageId'],
      source: SourceEnum.fromString(map['source']),
      isRegistered: map['isRegistered'],
      isSynced: map['isSynced']
    );
  }
  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
        personId: json['userId'],
        username: json['username'],
        name: "initial",
        source:SourceEnum.LOCAL
        ////
    );
  }
  Map<String,dynamic> toDb() => {
    'id': id,
    'personId':personId,
    'name': name,
    'username':username,
    'localName':localName,
    'description':description,
    'imageId':imageId,
    'source':source.toString(),
    'isRegistered':isRegistered,
    'isSynced':isSynced
  };
}
