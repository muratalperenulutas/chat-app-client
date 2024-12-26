import 'dart:convert';
import 'dart:io';
import 'package:chat_app/config/url.dart';
import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/services/group/GroupService.dart';
import 'package:chat_app/services/message/MessageService.dart';
import 'package:chat_app/services/user/UserService.dart';
import 'package:chat_app/services/websocket/WebsocketMessage.dart';
import 'package:chat_app/services/websocket/message_handler.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketClient extends GetxService {
  AuthController authController = Get.find<AuthController>();
  RxBool isWsConnected = false.obs;
  IOWebSocketChannel? channel;

  WebSocketClient() {
    ever(authController.isLoggedIn, (isLoggedIn) {
      if (isLoggedIn) {
        print("ws connect");
        _connect();
      } else {
        if (channel != null) {
          print("ws close");
          close();
        }
      }
    });
  }

  Future<void> _connect() async {
    //print('Function called from: ${StackTrace.current}');
    String accessToken = await authController.getAccessToken();
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };

    try {
      final webSocket =
          await WebSocket.connect(Url.websocket, headers: headers);
      channel = IOWebSocketChannel(webSocket);
      isWsConnected.value = true;
      channel?.stream.listen(
        (message) {
          handleMessage(message);
        },
        onError: (error) {
          print("WebSocket: Error occurred: $error");
        },
        onDone: () {
          print("WebSocket: Connection closed.");
          isWsConnected.value = false;
        },
      );
      // You can add any initial WebSocket commands if needed
      // sendWebsocketMessage(WebsocketMessage(WsCommandEnum.GET_GROUPS, null, null));
      GroupService.wsGetGroups();
      MessageService.wsGetMessages();
      UserService.findRegisteredUsers();
    } catch (e) {
      print("WebSocket connection failed: $e");
      isWsConnected.value = false;
    }
  }

  void sendWebsocketMessage(WebsocketMessage message) {
    String jsonMessage = jsonEncode(message.toJson());
    channel?.sink.add(jsonMessage);
    print("s");
  }

  void close() {
    channel?.sink.close();
  }
}
