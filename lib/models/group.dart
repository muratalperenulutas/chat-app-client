class GroupModel {
  final int? id;
  final int? groupId;
  final String? name;
  final String? ownerId;
  final int isDirectChat;
  final String? imageId;
  final int? isSynced;

  const GroupModel({
    this.id,
    this.groupId,
    this.name,
    this.ownerId,
    required this.isDirectChat,
    this.imageId,
    this.isSynced
  });
  factory GroupModel.fromDb(Map<String, dynamic> map) {
    return GroupModel(
      id: map['id'],
      groupId: map['groupId'],
      name: map['name'],
      ownerId:map['ownerId'],
      isDirectChat: map['isDirectChat'],
      imageId: map['imageId'],
      isSynced: map['isSynced']
    );
  }
  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
        groupId: json['id'],
      name: json['name'],
      ownerId: json['ownerId'],
      isDirectChat: json['isDirectChat']
    );
  }
  Map<String,dynamic> toDb() => {
    'id': id,
    'groupId':groupId,
    'name': name,
    'ownerId':ownerId,
    'isDirectChat':isDirectChat,
    'imageId':imageId,
    'isSynced':isSynced
  };
}
