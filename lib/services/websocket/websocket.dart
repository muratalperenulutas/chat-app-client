import 'dart:convert';
import 'dart:io';
import 'package:chat_app/config/url.dart';
import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/services/websocket/message_handler.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketClient extends GetxService {
  AuthController authController=Get.find<AuthController>();
  IOWebSocketChannel? channel;
  
  WebSocketClient() {
    ever(authController.isLoggedIn, (isLoggedIn)
    {
      if (isLoggedIn) {
        print("ws connect");
        _connect();
      } else {
        if(channel!=null){
          print("ws close");
          close();
        }
      }
    });
  }

  Future<void> _connect() async {
    print('Function called from: ${StackTrace.current}');
    String accessToken=await authController.getAccessToken();
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };

    final webSocket = await WebSocket.connect(Url.websocket, headers: headers);
    channel = IOWebSocketChannel(webSocket);
    channel?.stream.listen(
      (message) {
        handleMessage(message);
      },
    );
    sendCommand();
  }

  void sendCommand() {
    String jsonMessage = jsonEncode({
      'command': 'GET_GROUPS'});
    channel?.sink.add(jsonMessage);
    print("s");
  }

  void close() {
    channel?.sink.close();
  }
}