class GroupParticipantModel {
  final int? id;
  final int? groupId;
  final String? participantId;
  final int? isSynced;

  const GroupParticipantModel(
      {this.id, this.groupId, this.isSynced, this.participantId});

  factory GroupParticipantModel.fromDb(Map<String, dynamic> map) {
    return GroupParticipantModel(
      id: map['id'],
      groupId: map['groupId'],
      participantId: map['participantId'],
      isSynced: map['isSynced'],
    );
  }

  factory GroupParticipantModel.fromJson(Map<String, dynamic> json) {
    return GroupParticipantModel(
      id: json['id'],
      groupId: json['groupId'],
      participantId: json['userId'],
    );
  }

  Map<String, dynamic> toDb() => {
        'id': id,
        'groupId': groupId,
        'participantId': participantId,
        'isSynced': isSynced,
      };
}
