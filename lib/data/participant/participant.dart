class Participant {
  final int? id;
  final String? participantId;
  final String? collectivityId;
  final String? userId;

  const Participant(
      {this.participantId,this.id, this.userId, this.collectivityId});

  factory Participant.fromDb(Map<String, dynamic> map) {
    return Participant(
      id: map['id'],
      userId: map['userId'],
      collectivityId: map['collectivityId'],
    );
  }
  static List<Participant> fromJsonList(List<Map<String, dynamic>> json) {
    List<Participant> participants =
    <Participant>[];
    for (Map<String,dynamic> participant in json) {
      participants.add(Participant(
          collectivityId: participant['collectivityId'], userId:participant['userId'] ));
    }
    return participants;
  }

  Map<String, dynamic> toDb() => {
        'id': id,
        'userId': userId,
        'collectivityId': collectivityId,
      };
}
