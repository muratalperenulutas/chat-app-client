import 'package:chat_app/constants/enums/source_enum.dart';
import 'package:chat_app/constants/enums/status.dart';

class PersonModel {
  final int? id;
  final String? personId;
  final String? name;
  late String? localName;
  final String? username;
  final String? description;
  final String? imageId;
  late SourceEnum source;
  final int? isRegistered;
  Status status;

  PersonModel({
    this.id,
    this.personId,
    this.name,
    this.username,
    this.localName,
    this.description,
    this.imageId,
    this.source=SourceEnum.SERVER,
    this.isRegistered,
    this.status=Status.CREATED
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
      status: Status.fromString(map['status'])
    );
  }
  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
        personId: json['userId'],
        username: json['username'],
        name: "initial",
        status: Status.SYNC
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
    'source':source.name,
    'isRegistered':isRegistered,
    'status':status.name
  };

  void setLocalName(String name){
    localName=name;
  }
  void setSource(SourceEnum s){
    source=s;
  }
}
