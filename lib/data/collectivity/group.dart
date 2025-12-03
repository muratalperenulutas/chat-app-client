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
      Status status = Status.created})
      : super(
            collectivityId: collectivityId, type: CollectivityType.group, status: status, id: id);

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
        collectivityId: json['collectivityId'],
        name: json['name'],
        creatorId: json['creatorId'],
        imageId: json['imageId'],
        status: Status.sync);
  }
}
