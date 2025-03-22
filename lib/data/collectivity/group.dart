import 'package:chat_app/constants/enums/collectivity_type.dart';
import 'package:chat_app/data/collectivity/collectivity_abstract.dart';

import '../../constants/enums/status.dart';

class GroupModel extends Collectivity {
  final String? name;
  final String? creatorId;
  final String? imageId;

  GroupModel(
      {int? id,
      int? collectivityId,
      this.name,
      this.creatorId,
      this.imageId,
      Status status = Status.CREATED,
      CollectivityType type = CollectivityType.GROUP})
      : super(
            collectivityId: collectivityId, type: type, status: status, id: id);

  factory GroupModel.fromDb(Map<String, dynamic> map) {
    return GroupModel(
        id: map['id'],
        collectivityId: map['collectivityId'],
        name: map['name'],
        type:CollectivityType.fromString(map['collectivityType']),
        creatorId: map['creatorId'],
        imageId: map['imageId'],
        status: Status.fromString(map['status']));
  }

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
        collectivityId: json['id'],
        name: json['name'],
        creatorId: json['creatorId'],
        imageId: json['imageId'],
        status: Status.SYNC);
  }

  Map<String, dynamic> toDb() => {
        'id': id,
        'collectivityId': collectivityId,
        'name': name,
        'creatorId': creatorId,
        'imageId': imageId,
        'collectivityType': type.name,
        'status': status.name,
      };
}
