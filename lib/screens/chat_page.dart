import 'package:chat_app/models/chat_page_base.dart';
import 'package:chat_app/models/group.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/models/person.dart';
import 'package:chat_app/controller/app_controller.dart';
import 'package:chat_app/services/database/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  final GroupModel? groupModel;
  final PersonModel? personModel;

  const ChatPage({super.key, this.groupModel, this.personModel});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late Future<List<MessageModel>> _messagesFuture;
  String? _userId;
  ChatPageBaseModel? _chatPageBaseModel;
  bool _isLoading = true;
  final _messageController = TextEditingController();
  final AppController appController = Get.find<AppController>();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
    //  _userId = appController.userId;
      _chatPageBaseModel = await ChatPageBaseModel.createForChatPage(
          widget.groupModel, widget.personModel);
      _messagesFuture = DatabaseManager.getMessagesFromGroupById(
          _chatPageBaseModel!.groupId.toString());
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

  void sendMessage() async {
    String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      if (_chatPageBaseModel?.groupId == null) {
        
        // Create a new group if it doesn't exist

      }

      DatabaseManager.sendMessageToGroup(1, messageText, _userId! as int);
      _messageController.clear();
      setState(() {
        _messagesFuture = DatabaseManager.getMessagesFromGroupById(_chatPageBaseModel!.groupId.toString());
      });
    }
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
            : _buildChatContent(screenWidth));
  }

  Widget _buildChatContent(double screenWidth) {
    if (_chatPageBaseModel == null) {
      return const Center(child: Text("Chat data not available"));
    }
    if (_userId == null) {
      return const Center(child: Text("UserId not available"));
    }

    return Container(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder<List<MessageModel>>(
                  future: _messagesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      List<MessageModel> messages = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          var message = messages[index];
                          bool isMyMessage =
                              message.senderId == _userId;
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: isMyMessage
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                Card(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(12.0),
                                    child: Text(message.message),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Text('Message data not found.');
                    }
                  },
                ),
                const SizedBox(
                  height: 60,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(5.0),
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
                          contentPadding:
                              EdgeInsets.fromLTRB(20, 5, 5, 5),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 25,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.send),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
