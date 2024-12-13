import 'package:chat_app/models/person.dart';
import 'package:chat_app/services/database/database.dart';
import 'package:chat_app/widgets/build_start_conversation_body.dart';
import 'package:flutter/material.dart';

class StartConversationPage extends StatefulWidget {
  const StartConversationPage({super.key});

  @override
  State<StartConversationPage> createState() => _StartConversationPageState();
}

class _StartConversationPageState extends State<StartConversationPage> {
  late Future<List<PersonModel>> _contactsOnChatAppFuture;
  late Future<List<PersonModel>> _contactsNotOnChatAppFuture;

  @override
  void initState() {
    super.initState();
    _contactsOnChatAppFuture=DatabaseManager.getContactsOnChatApp();
    _contactsNotOnChatAppFuture=DatabaseManager.getContactsNotOnChatApp();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Select Contact"),
      ),
      body: buildStartConversationBody(screenHeight,_contactsOnChatAppFuture,_contactsNotOnChatAppFuture),
    );
  }
}