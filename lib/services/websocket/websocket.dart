import 'dart:convert';
import 'package:chat_app/config/url.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketClient {
  final IOWebSocketChannel channel;

  WebSocketClient()
      : channel = IOWebSocketChannel.connect(Uri.parse(Url.websocket)) {
    channel.stream.listen(
      (message) {
        _handleMessage(message);
      },
    );
  }

  void sendCommand(String listId) {
    String jsonMessage = jsonEncode({
      'command': 'echo'});
    channel.sink.add(jsonMessage);
  }

  Future<void> _handleMessage(dynamic message) async {
    final jsonData = jsonDecode(message);
    print(jsonData);

  }

  void close() {
    channel.sink.close();
  }
}
