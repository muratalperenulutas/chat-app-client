import 'package:chat_app/models/group.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/services/database/database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends StatefulWidget {
  final GroupModel groupModel;
  const ChatPage({super.key, required this.groupModel});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late Future<List<MessageModel>> _messagesFuture;
  late Future<String?> _getUserIdFuture;

  @override
  void initState() {
    super.initState();
    _messagesFuture =
        DatabaseManager.getMessagesFromGroup(widget.groupModel.groupId);
    _getUserIdFuture = _getUserId();
  }

  Future<String?> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = await prefs.getString('user-id');
    return userId;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(widget.groupModel.name),
      ),
      body: FutureBuilder<String?>(
          future: _getUserIdFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Hata1: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              String? userId = snapshot.data;
              return Container(
                child: Stack(
                  children: [
                    Text("messages"),
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
            } else {
              return const Center(child: Text("User id not found !"));
            }
          }),
    );
  }
}
