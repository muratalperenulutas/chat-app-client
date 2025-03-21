import 'package:chat_app/constants/enums/collectivity_type.dart';
import 'package:chat_app/constants/enums/status.dart';
import 'package:chat_app/data/collectivity/collectivity_abstract.dart';
import 'package:chat_app/features/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DyadModel extends Collectivity {
  final String userId;

  DyadModel(
      {int? id,
      required this.userId,
      int? collectivityId,
      required Status status})
      : super(
            collectivityId: collectivityId,
            type: CollectivityType.DYAD,
            status: status,
            id: id);

  factory DyadModel.fromDb(Map<String, dynamic> map) {
    print("from db" + map.toString());
    return DyadModel(
      id: map['id'],
      userId: map['userId'],
      collectivityId: map['collectivityId'],
      status: Status.fromString(map['status']),
    );
  }

  factory DyadModel.fromJson(Map<String, dynamic> json) {
    AuthController authController = Get.find<AuthController>();
    var userIds = List<String>.from(json['members']);
    String? otherUserId = userIds
        .firstWhere((id) => id != authController.myId.value, orElse: () => '');
    return DyadModel(
        collectivityId: json['collectivityId'],
        userId: otherUserId,
        status: Status.SYNC);
  }

  Map<String, dynamic> toDb() => {
        'id': id,
        'userId': userId,
        'collectivityId': collectivityId,
        'status': status.name,
      };
}
