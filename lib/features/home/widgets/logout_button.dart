import 'package:auto_route/auto_route.dart';
import 'package:chat_app/features/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ref = ProviderScope.containerOf(context);
    AuthController authController = ref.read(authControllerProvider.notifier);
    return IconButton(
        onPressed: () {
          authController.logout();
          context.router.replacePath('/login');
        },
        icon: const Icon(Icons.logout));
  }
}
