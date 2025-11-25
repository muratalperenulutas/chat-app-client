import 'package:auto_route/auto_route.dart';
import 'package:chat_app/core/services/notification/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/controllers/auth_controller.dart';

PreferredSizeWidget buildAppBar(double screenHeight, BuildContext context) {
  final ref = ProviderScope.containerOf(context);
  AuthController authController = ref.read(authControllerProvider.notifier);
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
            context.router.replacePath('/login');
          },
          icon: const Icon(Icons.logout))
    ],
  );
}
