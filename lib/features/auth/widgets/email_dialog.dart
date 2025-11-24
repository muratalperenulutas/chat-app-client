import 'package:chat_app/features/auth/controllers/auth_controller.dart';
import 'package:chat_app/features/auth/models/register_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void showEmailDialog(BuildContext context, WidgetRef ref) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.3),
    transitionDuration: Duration(milliseconds: 250),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            width: 350,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'We have sent an email. Please verify!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => ref
                      .read(authControllerProvider.notifier)
                      .setRegisterProgress(RegisterProgress.completed),
                  child: Text('Ok'),
                ),
              ],
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        ),
        child: child,
      );
    },
  );
}