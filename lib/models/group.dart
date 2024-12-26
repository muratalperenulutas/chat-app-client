import 'package:chat_app/models/sourceEnum.dart';

class GroupModel {
  late int? id;
  final int? groupId;
  final String? name;
  final String? ownerId;
  final int isDirectGroup;
  final String? imageId;
  final int? isSynced;

  GroupModel(
      {this.id,
      this.groupId,
      this.name,
      this.ownerId,
      required this.isDirectGroup,
      this.imageId,
      this.isSynced});

  factory GroupModel.fromDb(Map<String, dynamic> map) {
    return GroupModel(
        id: map['id'],
        groupId: map['groupId'],
        name: map['name'],
        ownerId: map['ownerId'],
        isDirectGroup: map['isDirectGroup'],
        imageId: map['imageId'],
        isSynced: map['isSynced'],
      );
  }

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
        groupId: json['id'],
        name: json['name'],
        ownerId: json['ownerId'],
        isDirectGroup: json['isDirectGroup'] ?? 0);
  }

  Map<String, dynamic> toDb() => {
        'id': id,
        'groupId': groupId,
        'name': name,
        'ownerId': ownerId,
        'isDirectGroup': isDirectGroup,
        'imageId': imageId,
        'isSynced': isSynced
      };

  void setId(int id) {
    this.id = id;
  }
}
