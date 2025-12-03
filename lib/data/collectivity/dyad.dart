import 'package:chat_app/constants/enums/collectivity_type.dart';
import 'package:chat_app/constants/enums/status.dart';
import 'package:chat_app/data/collectivity/collectivity_abstract.dart';
import 'package:flutter/rendering.dart';

class Dyad extends Collectivity {
  final String userId;

  Dyad(
      {super.id,
      required this.userId,
      super.collectivityId,
      required super.status,
      super.type= CollectivityType.dyad});


  factory Dyad.fromJson(Map<String, dynamic> json, String myId) {
    var userIds = List<String>.from(json['members']);
    String? otherUserId = userIds
        .firstWhere((id) => id != myId, orElse: ()=>"");
    if(otherUserId==""){
      debugPrint("userIds$userIds");
      debugPrint("myId:$myId");
      debugPrint("other userId null");
      throw Error();
    }
    return Dyad(
        collectivityId: json['collectivityId'],
        userId: otherUserId,
        status: Status.sync);
  }
}
