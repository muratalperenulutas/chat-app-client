import 'package:chat_app/screens/add_contact_page.dart';
import 'package:chat_app/screens/start_conversation_page.dart';
import 'package:flutter/material.dart';

FloatingActionButton? myFloatingActionButton(BuildContext context,int index){
  switch (index) {
    case 1:
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => StartConversationPage()
            ));
      },
      child: Icon(Icons.message),
      backgroundColor: Colors.green,
    );
    case 2:
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(
            builder: (context) => addContactsPage()
        ));
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.green,
    );
    default:
      return null;
  }

}

