import 'package:chat_app/models/person.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:flutter/material.dart';

MaterialButton myStartConversationButton(
    BuildContext context, double screenHeight, PersonModel person) {
  return MaterialButton(
    height: screenHeight / 12,
    color: Color.fromARGB(255, 254, 255, 255),
    onPressed: () async {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(
            personModel: person,
          ),
        ),
      );
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
                  backgroundImage: AssetImage(
                      'assets/images/murat.png')
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Text(
                person.name,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                person.description??"",
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
