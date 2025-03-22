class Participant {
  final int? id;
  final int? collectivityId;
  final String? userId;

  const Participant(
      {this.id, this.userId, this.collectivityId});

  factory Participant.fromDb(Map<String, dynamic> map) {
    return Participant(
      id: map['id'],
      userId: map['userId'],
      collectivityId: map['collectivityId'],
    );
  }
  static List<Participant> fromJson(Map<String, dynamic> json) {
    List<Participant> participants =
    <Participant>[];
    for (String userId in json['members']) {
      participants.add(Participant(
          collectivityId: json['id'], userId: userId));
    }
    return participants;
  }

  Map<String, dynamic> toDb() => {
        'id': id,
        'userId': userId,
        'collectivityId': collectivityId,
      };
}
