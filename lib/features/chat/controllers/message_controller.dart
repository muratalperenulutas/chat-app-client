import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/core/general_change_notifier.dart';
import 'package:chat_app/data/collectivity/collectivity_service.dart';
import 'package:chat_app/data/message/message_repository.dart';
import 'package:chat_app/data/message/message_service.dart';
import 'package:chat_app/features/chat/controllers/message_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message_controller.g.dart';

@Riverpod(keepAlive: true)
class MessageController extends _$MessageController {
  late final MessageRepository messageRepository = getIt<MessageRepository>();
  late final GeneralChangeNotifier generalChangeNotifier = getIt<GeneralChangeNotifier>();

  @override
  MessageState build() {
    void listener() {
      _loadData();
    }
    generalChangeNotifier.isMessagesChanged.addListener(listener);
    ref.onDispose(() => generalChangeNotifier.isMessagesChanged.removeListener(listener));
    
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
    final messageService = ref.read(messageServiceProvider);
    if (message.isNotEmpty) {
      if (collectivityId != null) {
        messageService.sendMessageByCollectivityId(message, collectivityId);
      } else if (userId != null) {
        final collectivityService = ref.read(collectivityServiceProvider);
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
