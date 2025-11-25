import 'package:chat_app/features/person/controller/person_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'my_contacts_button.dart';

Widget buildContactsBody(double screenHeight) {
  return Consumer(
    builder: (context, ref, child) {
      final personState = ref.watch(personControllerProvider);
      final contacts = personState.contacts;

      if (contacts.isEmpty) {
        return const Center(child: Text("No contact found!"));
      }

      return SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return myContactsButton(context, screenHeight, contacts[index]);
              },
            ),
            SizedBox(
              height: screenHeight / 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("You have ${contacts.length} contacts.")],
              ),
            ),
          ],
        ),
      );
    },
  );
}
