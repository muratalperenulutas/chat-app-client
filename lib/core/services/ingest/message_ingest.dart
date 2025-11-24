import 'package:chat_app/constants/enums/status.dart';
import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/core/services/websocket/websocket_client.dart';
import 'package:chat_app/data/message/message.dart';
import 'package:chat_app/data/message/message_repository.dart';

import '../../../constants/enums/ws_message_type.dart';
import '../../general_change_notifier.dart';
import '../websocket/models/send_message.dart';
import '../websocket/models/websocket_message.dart';

class MessageDataIngest {
  final GeneralChangeNotifier generalChangeNotifier = getIt<GeneralChangeNotifier>();
  final MessageRepository messageRepository = getIt<MessageRepository>();
  final WebSocketClient webSocketClient = getIt<WebSocketClient>();

  MessageDataIngest() {
    // TODO: Add reactivity(Auto sync when connectivity is back or on data changes)
  }

  void syncMessages() async {
    if (webSocketClient.isWsConnected) {
      List<Message> messages = await messageRepository.getAllUnsyncedCollectivityMessages();
      await messageRepository.printAll();
      for (Message message in messages) {
        sendMessage(message.message, message.collectivityId, message.id);
        message.status = Status.pending;
        messageRepository.updateMessageWithoutNotifier(message);
      }
    }
  }

  void sendMessage(message, collectivityId, requestId) async {
    WebsocketMessage wsMessage = WebsocketMessage(WsMessageType.SEND_MESSAGE, requestId.toString(), SendMessage(message, collectivityId));
    webSocketClient.sendWebsocketMessage(wsMessage);
  }
}