import 'package:chat_app/models/ToJson.dart';
import 'package:chat_app/services/websocket/wsMessageType.dart';

class WebsocketMessage {
  late WsMessageType type;
  late String? requestId;
  late Object? data;

  WebsocketMessage(this.type, this.requestId, this.data);

  Map<String, dynamic> toJson() {
    return {
      'command': type.name,
      'requestId': requestId,
      'data': _dataToJson(data),
    };
  }

  dynamic _dataToJson(Object? data) {
    if (data is JsonSerializable) {
      return data.toJson();
    }
    return data;
  }
}
