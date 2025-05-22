import 'package:chat_app/features/auth/controllers/auth_controller.dart';
import 'package:chat_app/features/chat/controllers/message_controller.dart';
import 'package:chat_app/features/chat/models/chat_base.dart';
import 'package:chat_app/features/person/screens/collectivity_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../widgets/my_message_bubble.dart';

class ChatPage extends StatefulWidget {
  final ChatBase chatBase;

  const ChatPage({super.key, required this.chatBase});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  MessageController messageController = Get.find<MessageController>();
  AuthController authController = Get.find<AuthController>();
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

      if (!visibleIndexes.contains(messageController.messages.length)) {
        //print("Bottom is not visible — maybe show 'scroll to bottom' button");
      }
    });
  }

  void scrollToBottom() {
    if (itemScrollController.isAttached) {
      itemScrollController.scrollTo(
        index: messageController.messages.length - 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _loadData() async {
    try {
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
      print('Error loading data: $e');
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
              Get.to(() => CollectivityDetailPage(
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
          Obx(() {
            var messages = messageController.messages;
            print(messages.length);
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
                      authController.myId.value) {
                print(visibleIndexes);
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
                      message.userId == authController.myId.value;
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
          }),
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
