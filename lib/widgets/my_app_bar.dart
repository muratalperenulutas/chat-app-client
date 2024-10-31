import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/services/auth/auth.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(double screenHeight, BuildContext context) {
  return AppBar(
    leading: IconButton(
      onPressed: () {},
      icon: Icon(Icons.menu),
    ),
    backgroundColor: Colors.green,
    toolbarHeight: screenHeight / 16,
    title: Text("Chat App "),
    actions: [
      IconButton(
          onPressed: () {
            AuthService.logout();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: ((context) => const LoginPage()),
              ),
            );
          },
          icon: const Icon(Icons.logout))
    ],
  );
}
