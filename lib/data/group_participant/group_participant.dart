class GroupParticipantModel {
  final int? id;
  final int? participantId;
  final int? localGroupId;
  final int? groupId;
  final String? userId;
  final int? isSynced;

  const GroupParticipantModel(
      {this.id,
      this.localGroupId,
      this.userId,
      this.groupId,
      this.isSynced,
      this.participantId});

  factory GroupParticipantModel.fromDb(Map<String, dynamic> map) {
    return GroupParticipantModel(
      id: map['id'],
      userId: map['userId'],
      localGroupId: map['localGroupId'],
      groupId: map['groupId'],
      participantId: map['participantId'],
      isSynced: map['isSynced'],
    );
  }

  factory GroupParticipantModel.fromJson(Map<String, dynamic> json) {
    return GroupParticipantModel(
        participantId: json['id'],
        groupId: json['groupId'],
        userId: json['userId'],
        isSynced: 1);
  }

  Map<String, dynamic> toDb() => {
        'id': id,
        'userId': userId,
        'localGroupId': localGroupId,
        'groupId': groupId,
        'participantId': participantId,
        'isSynced': isSynced,
      };
}
