import 'package:chat_app/core/models/JsonSerializable.dart';
import 'package:chat_app/constants/enums/ws_message_type.dart';

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
