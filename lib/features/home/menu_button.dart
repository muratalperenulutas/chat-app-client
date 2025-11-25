
import 'package:chat_app/core/services/notification/notification_service.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        NotificationService.instance.showLocalNotification(id: 3, title: "title", body: "body");
      },
      icon: Icon(Icons.menu),
    );
  }
}
