import 'package:chat_app/constants/enums/collectivity_type.dart';
import 'package:chat_app/data/collectivity/collectivity_abstract.dart';

import '../../constants/enums/status.dart';

class Group extends Collectivity {
  final String? name;
  final String? creatorId;
  final String? imageId;

  Group(
      {int? id,
      String? collectivityId,
      this.name,
      this.creatorId,
      this.imageId,
      Status status = Status.CREATED,
      CollectivityType type = CollectivityType.GROUP})
      : super(
            collectivityId: collectivityId, type: type, status: status, id: id);

  factory Group.fromDb(Map<String, dynamic> map) {
    return Group(
        id: map['id'],
        collectivityId: map['collectivityId'],
        name: map['name'],
        type: CollectivityType.fromString(map['collectivity_type']),
        creatorId: map['creator_id'],
        imageId: map['image_id'],
        status: Status.fromString(map['status']));
  }

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
        collectivityId: json['collectivityId'],
        name: json['name'],
        creatorId: json['creatorId'],
        imageId: json['imageId'],
        status: Status.SYNC);
  }

  Map<String, dynamic> toDb() => {
        'id': id,
        'collectivityId': collectivityId,
        'name': name,
        'creator_id': creatorId,
        'image_id': imageId,
        'collectivity_type': type.name,
        'status': status.name,
      };
}
