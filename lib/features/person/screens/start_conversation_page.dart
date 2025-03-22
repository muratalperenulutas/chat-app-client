import 'package:chat_app/features/person/controller/person_controller.dart';
import 'package:chat_app/features/person/widgets/my_select_contacts_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
  PersonController personController=Get.find<PersonController>();

  @override
  void dispose() {
    print("dispose");
    personController.resetSelectedContacts();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: MySelectContactsAppBar(),
      body: buildStartConversationBody(screenHeight),
    );
  }
}
