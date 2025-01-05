import 'package:chat_app/constants/enums/chat_page_base_model_source.dart';
import 'package:chat_app/features/auth/controllers/auth_controller.dart';
import 'package:chat_app/features/chat/controllers/message_controller.dart';
import 'package:chat_app/features/chat/models/chat_page_base.dart';
import 'package:chat_app/features/chat/services/chat_page_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/group/group.dart';
import '../../../data/person/person.dart';

class ChatPage extends StatefulWidget {
  final GroupModel? groupModel;
  final PersonModel? personModel;

  const ChatPage({super.key, this.groupModel, this.personModel});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  MessageController messageController = Get.put(MessageController());
  AuthController authController = Get.find<AuthController>();
  ChatPageService chatPageService = Get.find<ChatPageService>();
  ChatPageBaseModel? _chatPageBaseModel;
  bool _isLoading = true;
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      _chatPageBaseModel = await chatPageService
          .createChatPageBaseModelFromGroupModelAndPersonModel(
              widget.groupModel, widget.personModel);
      if (_chatPageBaseModel?.source != ChatPageBaseModelSource.CONTACT) {
        messageController
            .setLocalGroupId(_chatPageBaseModel!.localGroupId ?? 0);
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

  void _setGroupId(int id) {
    _chatPageBaseModel?.localGroupId = id;
    messageController.setLocalGroupId(id);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(_chatPageBaseModel?.name ?? "Chat"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildChatContent(screenWidth),
    );
  }

  Widget _buildChatContent(double screenWidth) {
    if (_chatPageBaseModel == null) {
      return const Center(child: Text("Chat data not available"));
    }

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
                          message.userId == authController.userId.value;
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
                        controller: _messageController,
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
                            _messageController.text,
                            _chatPageBaseModel?.localGroupId,
                            _chatPageBaseModel?.personId,
                            _setGroupId);
                        _messageController.clear();
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
