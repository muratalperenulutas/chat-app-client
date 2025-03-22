import 'package:chat_app/features/chat/models/chat_base.dart';
import 'package:chat_app/features/chat/screens/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

myConversationButton(
    BuildContext context, double screenHeight, ChatBaseModel chatBase) {
  return MaterialButton(
    height: screenHeight / 12,
    color: Color.fromARGB(255, 254, 255, 255),
    onPressed: () {
      Get.to(() => ChatPage(
            chatBaseModel: chatBase,
          ));
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
                      'assets/images/murat.png') //NetworkImage()                            ),
                  ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Text(
                chatBase.name ?? "",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                chatBase.collectivityId.toString(),
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
