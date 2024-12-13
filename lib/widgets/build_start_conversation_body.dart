import 'package:chat_app/models/person.dart';
import 'package:chat_app/widgets/my_contacts_button.dart';
import 'package:chat_app/widgets/my_start_conversation_button.dart';
import 'package:flutter/material.dart';

Widget buildStartConversationBody(
    double screenHeight,
    Future<List<PersonModel>> contactsOnChatAppFuture,
    Future<List<PersonModel>> contactsNotOnChatAppFuture,
    ) {
  return FutureBuilder<List<PersonModel>>(
    future: contactsOnChatAppFuture,
    builder: (context, snapshotOnChatApp) {
      if (snapshotOnChatApp.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshotOnChatApp.hasError) {
        return const Center(child: Text("Error loading contacts!"));
      //} else if (!snapshotOnChatApp.hasData || snapshotOnChatApp.data!.isEmpty) {
        //return const Center(child: Text("No contacts found on the app!"));
      } else {
        final contactsOnChatApp = snapshotOnChatApp.data!;
        return FutureBuilder<List<PersonModel>>(
          future: contactsNotOnChatAppFuture,
          builder: (context, snapshotNotOnChatApp) {
            if (snapshotNotOnChatApp.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshotNotOnChatApp.hasError) {
              return const Center(child: Text("Error loading contacts not on the app!"));
            //} else if (!snapshotNotOnChatApp.hasData || snapshotNotOnChatApp.data!.isEmpty) {
              //return const Center(child: Text("No contacts found not on the app!"));
            } else {
              final contactsNotOnChatApp = snapshotNotOnChatApp.data!;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text("Contacts on Chat App"),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: contactsOnChatApp.length,
                          itemBuilder: (context, index) {
                            return myStartConversationButton(context, screenHeight, contactsOnChatApp[index]);
                          },
                        ),
                      ],
                    ),
                    const Divider(),
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text("Contacts Not on Chat App"),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: contactsNotOnChatApp.length,
                          itemBuilder: (context, index) {
                            return myStartConversationButton(context, screenHeight, contactsNotOnChatApp[index]);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        );
      }
    },
  );
}
