import 'package:chat_app/features/chat/screens/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/person/person.dart';

MaterialButton myStartConversationButton(
    BuildContext context, double screenHeight, PersonModel person) {
  return MaterialButton(
    height: screenHeight / 12,
    color: Color.fromARGB(255, 254, 255, 255),
    onPressed: () async {
      if (person.isRegistered == 1) {
        Get.to(() => ChatPage(
              personModel: person,
            ));
      }
    },
    child: Padding(
      padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 65,
            height: 65,
            child: const CircleAvatar(
              radius: 32.5,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/murat.png')),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Text(
                person.localName ?? "",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                person.description ?? "",
                style: TextStyle(
                    fontSize: 14, color: Color.fromARGB(255, 85, 92, 94)),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
