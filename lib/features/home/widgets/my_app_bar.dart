import 'package:chat_app/features/home/menu_button.dart';
import 'package:chat_app/features/home/widgets/logout_button.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget buildAppBar(double screenHeight,bool isWideScreen, BuildContext context) {
  return AppBar(
    leading:isWideScreen ? null : MenuButton(),
    backgroundColor: Colors.green,
    toolbarHeight: screenHeight / 16,
    title: Text("Chat App "),
    actions: [
      LogoutButton()
    ],
  );
}