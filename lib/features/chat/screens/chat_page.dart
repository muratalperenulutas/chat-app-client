import 'package:auto_route/auto_route.dart';
import 'package:chat_app/core/router/app_router.dart';
import 'package:chat_app/features/auth/controllers/auth_controller.dart';
import 'package:chat_app/features/chat/controllers/message_controller.dart';
import 'package:chat_app/features/chat/models/chat_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../widgets/my_message_bubble.dart';

@RoutePage()
class ChatPage extends ConsumerStatefulWidget {
  final ChatBase chatBase;

  const ChatPage({super.key, required this.chatBase});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  bool _isLoading = true;
  final _messageTextController = TextEditingController();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  bool hasJumpedToBottom = false;
  List visibleIndexes = List.empty();

  @override
  void initState() {
    super.initState();
    _loadData();
    itemPositionsListener.itemPositions.addListener(() {
      final positions = itemPositionsListener.itemPositions.value;
      visibleIndexes = positions.map((e) => e.index).toList();

      final messageState = ref.read(messageControllerProvider);
      if (!visibleIndexes.contains(messageState.messages.length)) {
        //print("Bottom is not visible — maybe show 'scroll to bottom' button");
      }
    });
  }

  void scrollToBottom() {
    if (itemScrollController.isAttached) {
      final messageState = ref.read(messageControllerProvider);
      itemScrollController.scrollTo(
        index: messageState.messages.length - 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _loadData() async {
    try {
      final messageController = ref.read(messageControllerProvider.notifier);
      if (widget.chatBase.collectivityId != null) {
        messageController
            .setCollectivityId(widget.chatBase.collectivityId ??"");
      }
      if (widget.chatBase.personId != null) {
        messageController.setUserId(widget.chatBase.personId ?? "");
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      debugPrint('Error loading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Container(
          width: double.infinity,
          child: GestureDetector(
            onTap: () {
              context.router.push(CollectivityDetailRoute(
                    chatBase: widget.chatBase,
                  ));
            },
            child: Text(
              widget.chatBase.name ?? "Chat",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildChatContent(screenWidth),
    );
  }

  Widget _buildChatContent(double screenWidth) {
    return Container(
      child: Stack(
        children: [
          Consumer(
            builder: (context, ref, child) {
              final messageState = ref.watch(messageControllerProvider);
              final authState = ref.watch(authControllerProvider);
              var messages = messageState.messages;
              debugPrint(messages.length.toString());
              if (messages.isEmpty) {
                return const Center(child: Text("No messages available"));
              }
              if (messages.isNotEmpty) {
                if (!hasJumpedToBottom) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    itemScrollController.jumpTo(index: messages.length - 1);
                    hasJumpedToBottom = true;
                  });
                } else if (visibleIndexes.contains(messages.length - 1) ||
                    messages[messages.length - 1].userId ==
                        authState.myId) {
                  debugPrint(visibleIndexes.toString());
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    scrollToBottom();
                  });
                }
              }
              return Positioned.fill( child:ScrollablePositionedList.builder(
                  itemCount: messages.length + 1,
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                  itemBuilder: (context, index) {
                    if (messages.length == index) {
                      return const SizedBox(
                        height: 60,
                      );
                    }
                    var message = messages[index];
                    bool isMyMessage =
                        message.userId == authState.myId;
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: isMyMessage
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          MyMessageBubble(message: message, collectivityId: widget.chatBase.collectivityId??"")
                        ],
                      ),
                    );
                  }
                  )
              );
            }
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: SizedBox(
                      width: screenWidth - 80,
                      child: TextFormField(
                        maxLines: 6,
                        minLines: 1,
                        controller: _messageTextController,
                        decoration: const InputDecoration(
                          hintText: "Type a message",
                          contentPadding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 25,
                    child: IconButton(
                      onPressed: () async {
                        final messageController = ref.read(messageControllerProvider.notifier);
                        await messageController.sendMessage(
                            _messageTextController.text,
                            widget.chatBase.collectivityId,
                            widget.chatBase.personId);
                        _messageTextController.clear();
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
