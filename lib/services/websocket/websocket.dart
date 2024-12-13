import 'dart:convert';
import 'dart:io';
import 'package:chat_app/config/url.dart';
import 'package:chat_app/services/websocket/message_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketClient {
  late final IOWebSocketChannel channel;
  
  WebSocketClient() {
    _connect();
  }

  Future<void> _connect() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = await prefs.getString('access-token') ?? '';

    final headers = {
      'Authorization': 'Bearer $accessToken',
    };

    final webSocket = await WebSocket.connect(Url.websocket, headers: headers);
    channel = IOWebSocketChannel(webSocket);
    channel.stream.listen(
      (message) {
        handleMessage(message);
      },
    );
    sendCommand();
  }

  void sendCommand() {
    String jsonMessage = jsonEncode({
      'command': 'GET_GROUPS'});
    channel.sink.add(jsonMessage);
    print("s");
  }

  void close() {
    channel.sink.close();
  }
}
