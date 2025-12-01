import 'package:chat_app/features/person/models/person_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/person_controller.dart';
import 'my_start_conversation_button.dart';

class BuildStartConversationBody extends ConsumerWidget {
  final double screenHeight;

  const BuildStartConversationBody({super.key, required this.screenHeight});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personState = ref.watch(personControllerProvider);

    final contactsOnChatApp = personState.contactsOnChatApp;
    final contactsNotOnChatApp = personState.contactsNotOnChatApp;

    if (contactsOnChatApp.isEmpty && contactsNotOnChatApp.isEmpty) {
      return const Center(child: Text("No contacts found"));
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
                return MyStartConversationButton(
                    screenHeight: screenHeight, personBase: PersonBase.fromContact(contactsOnChatApp[index]));
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
                return MyStartConversationButton(
                    screenHeight: screenHeight, personBase: PersonBase.fromContact(contactsNotOnChatApp[index]));
              },
            ),
          ],
        ],
      ),
    );
  }
}
