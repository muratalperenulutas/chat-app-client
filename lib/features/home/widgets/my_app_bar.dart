import 'package:chat_app/core/services/notification/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../auth/controllers/auth_controller.dart';

AppBar buildAppBar(double screenHeight, BuildContext context) {
  AuthController authController = Get.find<AuthController>();
  return AppBar(
    leading: IconButton(
      onPressed: () {
        NotificationService.instance.showLocalNotification(id: 3, title: "title", body: "body");
      },
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
