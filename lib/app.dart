import 'package:chat_app/features/home/screens/home_screen.dart';
import 'package:chat_app/features/auth/screens/login_screen.dart';
import 'package:chat_app/features/auth/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/auth/controllers/auth_controller.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    return Obx(() {
      print(
          "Logged in: ${authController.isLoggedIn.value}, Loading: ${authController.isLoading.value}");
      if (authController.isLoading.value) {
        return const MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      } else {
        return GetMaterialApp(
          initialRoute: authController.isLoggedIn.value ? '/home' : '/login',
          getPages: [
            GetPage(name: '/home', page: () => HomePage()),
            GetPage(name: '/login', page: () => LoginPage()),
            GetPage(name: '/register', page: () => RegisterPage()),
          ],
          debugShowCheckedModeBanner: false,
        );
      }
    });
  }
}
