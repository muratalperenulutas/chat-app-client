class GroupModel {
  final String name;
  final String? id;
  final String? groupId; 
  final String isDirectChat; 

  const GroupModel({
    required this.name,
    this.id,
    this.groupId,
    this.isDirectChat = "0", 
  });
  factory GroupModel.fromDb(Map<String, dynamic> map) {
    return GroupModel(
      name: map['name'],
      id: map['id'].toString(),
      groupId:map['groupId'].toString(),
      isDirectChat: map['isDirectChat'].toString(),
    );
  }
  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      name: json['name'],
      groupId: json['id'],
      isDirectChat: json['isDirectChat'],
    );
  }
  Map<String,dynamic> toDb() => {
    'name': name,
    'groupId': groupId,
    'isDirectChat':isDirectChat
  };
}
