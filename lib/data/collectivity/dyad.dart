import 'package:chat_app/constants/enums/collectivity_type.dart';
import 'package:chat_app/constants/enums/status.dart';
import 'package:chat_app/data/collectivity/collectivity_abstract.dart';
import 'package:flutter/rendering.dart';

class Dyad extends Collectivity {
  final String userId;

  Dyad(
      {int? id,
      required this.userId,
      String? collectivityId,
      required Status status,
      CollectivityType type= CollectivityType.dyad})
      : super(
            collectivityId: collectivityId,
            type:type,
            status: status,
            id: id);

  factory Dyad.fromDb(Map<String, dynamic> map) {
    debugPrint("from db$map");
    return Dyad(
      id: map['id'],
      userId: map['user_id'] ?? "",
      collectivityId: map['collectivityId'],
      status: Status.fromString(map['status']),
      type: CollectivityType.fromString(map['collectivity_type'])
    );
  }

  factory Dyad.fromJson(Map<String, dynamic> json, String myId) {
    var userIds = List<String>.from(json['members']);
    String? otherUserId = userIds
        .firstWhere((id) => id != myId, orElse: ()=>"");
    if(otherUserId==""){
      debugPrint("userIds"+userIds.toString());
      debugPrint("myId:"+myId);
      debugPrint("other userId null");
      throw Error();
    }
    return Dyad(
        collectivityId: json['collectivityId'],
        userId: otherUserId,
        status: Status.sync);
  }

  Map<String, dynamic> toDb() => {
        'id': id,
        'user_id': userId,
        'collectivityId': collectivityId,
        'status': status.name,
        'collectivity_type': type.name
      };
}
