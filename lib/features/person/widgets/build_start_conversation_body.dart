import 'package:chat_app/features/person/controller/person_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_start_conversation_button.dart';

Widget buildStartConversationBody(double screenHeight) {
  PersonController personController = Get.find<PersonController>();

  return Obx(() {
    final contactsOnChatApp = personController.contactsOnChatApp;
    final contactsNotOnChatApp = personController.contactsNotOnChatApp;

    if (contactsOnChatApp.isEmpty && contactsNotOnChatApp.isEmpty) {
      return const Center(child: Text("No contacts found"));
     // return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          if (contactsOnChatApp.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text("Contacts on Chat App"),
            ),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: contactsOnChatApp.length,
              itemBuilder: (context, index) {
                return myStartConversationButton(
                    context, screenHeight, contactsOnChatApp[index]);
              },
            ),
            const Divider(),
          ],

          if (contactsNotOnChatApp.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text("Contacts Not on Chat App"),
            ),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: contactsNotOnChatApp.length,
              itemBuilder: (context, index) {
                return myStartConversationButton(
                    context, screenHeight, contactsNotOnChatApp[index]);
              },
            ),
          ],
        ],
      ),
    );
  });
}
