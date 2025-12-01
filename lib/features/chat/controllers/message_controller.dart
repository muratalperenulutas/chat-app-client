import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/data/collectivity/collectivity_service.dart';
import 'package:chat_app/data/message/message_repository.dart';
import 'package:chat_app/data/message/message_service.dart';
import 'package:chat_app/features/chat/controllers/message_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message_controller.g.dart';

@Riverpod(keepAlive: true)
class MessageController extends _$MessageController {
  late final MessageRepository messageRepository = getIt<MessageRepository>();

  @override
  MessageState build() {
    void listener() {
      _loadData();
    }
    //TO DO: Replace with more specific listener
    //generalChangeNotifier.isMessagesChanged.addListener(listener);
    //ref.onDispose(() => generalChangeNotifier.isMessagesChanged.removeListener(listener));
    
    _loadData();
    
    return MessageState();
  }

  void _loadData() async {
    final messages = await messageRepository.getMessagesByCollectivityIdOrDyadReceiverId(
      state.collectivityId,
      state.userId
    );
    state = state.copyWith(messages: messages);
  }

  Future<void> sendMessage(String message, String? collectivityId, String? userId) async {
    final messageService = getIt<MessageService>();
    if (message.isNotEmpty) {
      if (collectivityId != null) {
        messageService.sendMessageByCollectivityId(message, collectivityId);
      } else if (userId != null) {
        final collectivityService = getIt<CollectivityService>();
        await collectivityService.createDyadIfNotExist(userId);
        messageService.sendMessageByReceiverId(message, userId);
      } else {
        throw Error();
      }
    }
  }

  void setCollectivityId(String id) {
    state = state.copyWith(collectivityId: id, userId: null);
    _loadData();
  }
  
  void setUserId(String id) {
    state = state.copyWith(userId: id, collectivityId: null);
    _loadData();
  }
}
