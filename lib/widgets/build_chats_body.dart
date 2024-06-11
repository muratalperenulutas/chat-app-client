import 'package:chat_app/widgets/my_conversation_button.dart';
import 'package:flutter/material.dart';

SingleChildScrollView buildChatsBody(double screenHeight) {
  return SingleChildScrollView(
    child: Column(
      children: [
        SingleChildScrollView(
          child: Column(children: [
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: 10,
              itemBuilder: (context, index) {
                return myConversationButton(screenHeight);
              },
            ),
          ]),
        ),
      ],
    ),
  );
}
