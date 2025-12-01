import 'dart:async';

import 'package:chat_app/constants/enums/status.dart';
import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/core/services/sync/sync.dart';
import 'package:chat_app/data/message/message.dart';
import 'package:chat_app/data/message/message_repository.dart';

import '../../../constants/enums/ws_message_type.dart';
import '../websocket/models/send_message.dart';
import '../websocket/models/websocket_message.dart';

class MessageSyncService {
  final MessageRepository messageRepository = getIt<MessageRepository>();
  final SyncService syncService = getIt<SyncService>();
  
  StreamSubscription<List<Message>>? _unsyncedMessagesSubscription;

  MessageSyncService() {
    _setupAutoSync();
    syncMessages();
  }

  void _setupAutoSync() {
    _unsyncedMessagesSubscription = messageRepository.watchUnsyncedCollectivityMessages().listen((messages) {
      if (messages.isNotEmpty) {
        _syncMessages(messages);
      }
    });
  }

  void _syncMessages(List<Message> messages) async {
    for (Message message in messages) {
      _sendMessage(message.message, message.collectivityId, message.id);
      message.status = Status.pending;
      await messageRepository.updateMessage(message);
    }
  }

  void syncMessages() async {
    List<Message> messages = await messageRepository.getAllUnsyncedCollectivityMessages();
    _syncMessages(messages);
  }

  void _sendMessage(message, collectivityId, requestId) {
    if (collectivityId == null || collectivityId.isEmpty || collectivityId == '') {
      return;
    }
    WebsocketMessage wsMessage = WebsocketMessage(
      WsMessageType.SEND_MESSAGE, 
      requestId.toString(), 
      SendMessage(message, collectivityId)
    );
    syncService.sendMessage(wsMessage);
  }
  
  void dispose() {
    _unsyncedMessagesSubscription?.cancel();
  }
}