import 'package:chat_app/constants/enums/source_enum.dart';
import 'package:chat_app/constants/enums/status.dart';

class Person {
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

  Person({
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
  factory Person.fromDb(Map<String, dynamic> map) {
    return Person(
      id: map['id'],
      personId: map['person_id'],
      name: map['name'],
      username: map['username'],
      localName: map['local_name'],
      description: map['description'],
      imageId: map['image_id'],
      source: SourceEnum.fromString(map['source']),
      isRegistered: map['is_registered'],
      status: Status.fromString(map['status'])
    );
  }
  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
        personId: json['userId'],
        username: json['username'],
        name: "initial",
        status: Status.SYNC
        ////
    );
  }
  Map<String,dynamic> toDb() => {
    'id': id,
    'person_id': personId,
    'name': name,
    'username': username,
    'local_name': localName,
    'description': description,
    'image_id': imageId,
    'source': source.name,
    'is_registered': isRegistered,
    'status': status.name
  };

  void setLocalName(String name){
    localName=name;
  }
  void setSource(SourceEnum s){
    source=s;
  }
}
