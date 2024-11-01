class GroupModel {
  final String name;
  final String id;
  final int groupId; 
  final int isDirectChat; 

  const GroupModel({
    required this.name,
    required this.id,
    required this.groupId,
    this.isDirectChat = 0, 
  });
  factory GroupModel.fromDb(Map<String, dynamic> map) {
    return GroupModel(
      name: map['name'],
      id: map['id'].toString(),
      groupId: map['groupId'],
      isDirectChat: map['isDirectChat'],
    );
  }
}
