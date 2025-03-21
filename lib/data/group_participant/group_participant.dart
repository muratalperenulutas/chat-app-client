class GroupParticipant {
  final int? id;
  final int? collectivityId;
  final String? userId;

  const GroupParticipant(
      {this.id, this.userId, this.collectivityId});

  factory GroupParticipant.fromDb(Map<String, dynamic> map) {
    return GroupParticipant(
      id: map['id'],
      userId: map['userId'],
      collectivityId: map['collectivityId'],
    );
  }

  List<GroupParticipant> fromJson(Map<String, dynamic> json) {
    List<GroupParticipant> participants =
        <GroupParticipant>[];
    for (String userId in json['members']) {
      participants.add(GroupParticipant(
          collectivityId: json['collectivityId'], userId: json['userId']));
    }
    return participants;
  }

  Map<String, dynamic> toDb() => {
        'id': id,
        'userId': userId,
        'collectivityId': collectivityId,
      };
}
