import 'package:chat_app/constants/enums/collectivity_type.dart';
import 'package:chat_app/features/auth/controllers/auth_controller.dart';
import 'package:chat_app/features/chat/controllers/message_controller.dart';
import 'package:chat_app/features/chat/models/chat_base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  final ChatBaseModel chatBaseModel;

  const ChatPage({super.key, required this.chatBaseModel});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  MessageController messageController = Get.put(MessageController());
  AuthController authController = Get.find<AuthController>();
  bool _isLoading = true;
  final _messageTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      if(widget.chatBaseModel.collectivityId!=null) {
        messageController
            .setCollectivityId(widget.chatBaseModel.collectivityId ?? 0);
      }
      if(widget.chatBaseModel.personId!=null) {
        messageController.setUserId(widget.chatBaseModel.personId??"");
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
        backgroundColor: Colors.blue[900],
        title: Text(widget.chatBaseModel.name ?? "Chat"),
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
          SingleChildScrollView(
            child: Column(
              children: [
                Obx(() {
                  var messages = messageController.messages;
                  if (messages.isEmpty) {
                    return const Center(child: Text("No messages available"));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
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
                            Card(
                              color: Colors.purpleAccent,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(message.message),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: SizedBox(
                      width: screenWidth - 80,
                      child: TextFormField(
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
                      onPressed: () {
                        messageController.sendMessage(
                            _messageTextController.text,
                            widget.chatBaseModel.collectivityId,
                        widget.chatBaseModel.personId);
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
