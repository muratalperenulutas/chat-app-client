import 'package:chat_app/core/services/websocket/websocket_client.dart';
import 'package:chat_app/data/message/message.dart';
import 'package:chat_app/data/message/message_repository.dart';
import 'package:get/get.dart';

import '../../../constants/enums/ws_message_type.dart';
import '../../general_change_notifier.dart';
import '../websocket/models/send_message.dart';
import '../websocket/models/websocket_message.dart';

class MessageDataIngest extends GetxService{
  final GeneralChangeNotifier generalChangeNotifier=Get.find<GeneralChangeNotifier>();
  final MessageRepository messageRepository=Get.find<MessageRepository>();
  final WebSocketClient webSocketClient=Get.find<WebSocketClient>();

  MessageDataIngest(){
    ever(generalChangeNotifier.isMessagesChanged, (count) async {
        List<Message> messages=await messageRepository.getAllUnsyncedCollectivityMessages();
        await messageRepository.printAll();
        for(Message message in messages){
            sendMessage(message.message, message.collectivityId, message.id);
        }
    });
  }
  void sendMessage(message,collectivityId,requestId) async {
    WebsocketMessage wsMessage=WebsocketMessage(WsMessageType.SEND_MESSAGE, requestId.toString(), SendMessage(message, collectivityId));
    webSocketClient.sendWebsocketMessage(wsMessage);
  }
}