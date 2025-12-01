import 'dart:async';

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
  StreamSubscription? _messageSubscription;

  @override
  MessageState build() {
    ref.onDispose(() {
      _messageSubscription?.cancel();
    });
    return MessageState();
  }

  void _setupStream() {
    _messageSubscription?.cancel();
    
    String cId = state.collectivityId;
    String uId = state.userId;

    if (cId.isNotEmpty || uId.isNotEmpty) {
      _messageSubscription = messageRepository.watchMessagesByCollectivityIdOrDyadReceiverId(
        cId,
        uId
      ).listen((messages) {
        state = state.copyWith(messages: messages);
      });
    }
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
    state = state.copyWith(collectivityId: id, userId: '');
    _setupStream();
  }
  
  void setUserId(String id) {
    state = state.copyWith(userId: id, collectivityId: '');
    _setupStream();
  }

  void setChatIds({String? collectivityId, String? userId}) {
    state = state.copyWith(
      collectivityId: collectivityId ?? '',
      userId: userId ?? ''
    );
    _setupStream();
  }
}
