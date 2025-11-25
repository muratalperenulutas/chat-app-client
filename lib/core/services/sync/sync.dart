
import 'dart:async';

import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/core/services/websocket/models/websocket_message.dart';
import 'package:chat_app/core/services/websocket/websocket_client.dart';

class SyncService {
  final WebSocketClient webSocketClient = getIt<WebSocketClient>();
  
  final List<WebsocketMessage> _pendingMessages = [];
  StreamSubscription<ConnectionStatus>? _connectionStatusSubscription;

  SyncService() {
    _connectionStatusSubscription = webSocketClient.connectionStatusStream.listen((status) {
      if (status == ConnectionStatus.connected) {
        _flushPendingMessages();
      }
    });
  }

  void sendMessage(WebsocketMessage message) {
    if (webSocketClient.isWsConnected) {
      webSocketClient.sendWebsocketMessage(message);
    } else {
      _pendingMessages.add(message);
    }
  }

  void _flushPendingMessages() {
    for (var message in _pendingMessages) {
      webSocketClient.sendWebsocketMessage(message);
    }
    _pendingMessages.clear();
  }

  void dispose() {
    _connectionStatusSubscription?.cancel();
  }
}