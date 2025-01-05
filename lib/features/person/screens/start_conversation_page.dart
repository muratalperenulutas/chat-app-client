import 'package:flutter/material.dart';

import '../widgets/build_start_conversation_body.dart';

class StartConversationPage extends StatefulWidget {
  const StartConversationPage({super.key});

  @override
  State<StartConversationPage> createState() => _StartConversationPageState();
}

class _StartConversationPageState extends State<StartConversationPage> {

  @override
  void initState() {
    super.initState();
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
      body: buildStartConversationBody(screenHeight),
    );
  }
}