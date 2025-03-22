import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../auth/controllers/auth_controller.dart';

AppBar buildAppBar(double screenHeight, BuildContext context) {
  AuthController authController = Get.find<AuthController>();
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
            authController.logout();
            Get.offAllNamed('/login');
          },
          icon: const Icon(Icons.logout))
    ],
  );
}
