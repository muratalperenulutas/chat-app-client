import 'package:chat_app/app.dart';
import 'package:chat_app/core/bindings/initial_binding.dart';
import 'package:chat_app/core/services/notification/notification_service.dart';
import 'package:chat_app/data/database_service.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );
  } catch (e) {
    debugPrint('Firebase initialization error: $e');
  }

  try {
    await NotificationService.instance.initialize();
    debugPrint('Notification service initialized successfully');
  } catch (e) {
    debugPrint('Notification service initialization error: $e');
  }

  try {
    final databaseService = DatabaseService();
    await databaseService.onInit();
    Get.put<DatabaseService>(databaseService);
  } catch (e) {
    debugPrint('Database initialization error: $e');
  }

  InitialBinding().dependencies();

  runApp(MyApp());
}
