import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/app_controller.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
          initialRoute: '/',
          getPages: [
            GetPage(name: '/', page: () => HomePage()),
          ],
          debugShowCheckedModeBanner: false,
          home: appController.refreshToken.value==''?LoginPage():HomePage());
    });
  }
}