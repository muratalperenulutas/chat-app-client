import 'package:chat_app/core/models/JsonSerializable.dart';

class CollectivityId extends JsonSerializable {
  late String collectivityId;

  CollectivityId(this.collectivityId);

  @override
  Map<String, dynamic> toJson() {
    return {"id": collectivityId};
  }
}
