import 'package:chat_app/constants/enums/collectivity_type.dart';
import 'package:chat_app/constants/enums/status.dart';
import 'package:chat_app/data/collectivity/collectivity_abstract.dart';
import 'package:chat_app/features/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Dyad extends Collectivity {
  final String userId;

  Dyad(
      {int? id,
      required this.userId,
      String? collectivityId,
      required Status status,
      CollectivityType type= CollectivityType.DYAD})
      : super(
            collectivityId: collectivityId,
            type:type,
            status: status,
            id: id);

  factory Dyad.fromDb(Map<String, dynamic> map) {
    print("from db" + map.toString());
    return Dyad(
      id: map['id'],
      userId: map['userId']??"",
      collectivityId: map['collectivityId'],
      status: Status.fromString(map['status']),
      type:CollectivityType.fromString(map['collectivityType'])
    );
  }

  factory Dyad.fromJson(Map<String, dynamic> json) {
    AuthController authController = Get.find<AuthController>();
    var userIds = List<String>.from(json['members']);
    String? otherUserId = userIds
        .firstWhere((id) => id != authController.myId.value, orElse: ()=>"");
    if(otherUserId==""){
      print("userIds"+userIds.toString());
      print("myId:"+authController.myId.value);
      print("other userId null");
      throw Error();
    }
    return Dyad(
        collectivityId: json['collectivityId'],
        userId: otherUserId,
        status: Status.SYNC);
  }

  Map<String, dynamic> toDb() => {
        'id': id,
        'userId': userId,
        'collectivityId': collectivityId,
        'status': status.name,
        'collectivityType':type.name
      };
}
