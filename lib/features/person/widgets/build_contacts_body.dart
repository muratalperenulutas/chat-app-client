import 'package:chat_app/features/person/controller/person_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_contacts_button.dart';

Widget buildContactsBody(double screenHeight) {
  PersonController personController = Get.find<PersonController>();

  return Obx(() {
    final contacts = personController.contacts;

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
              return MyContactsButton(context, screenHeight, contacts[index]);
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
  });
}
