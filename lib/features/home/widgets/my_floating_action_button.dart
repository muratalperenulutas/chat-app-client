import 'package:auto_route/auto_route.dart';
import 'package:chat_app/core/router/app_router.dart';
import 'package:flutter/material.dart';

FloatingActionButton? myFloatingActionButton(BuildContext context,int index){
  switch (index) {
    case 1:
    return FloatingActionButton(
      onPressed: () {
        context.router.push(const StartConversationRoute());
      },
      backgroundColor: Colors.green,
      child: Icon(Icons.message),
    );
    case 2:
    return FloatingActionButton(
      onPressed: () {
        context.router.push(const AddContactsRoute()
        );
      },
      backgroundColor: Colors.green,
      child: Icon(Icons.add),
    );
    default:
      return null;
  }

}

