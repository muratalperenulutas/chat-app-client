import 'package:chat_app/app.dart';
import 'package:chat_app/services/websocket/websocket.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController());
  Get.put(WebSocketClient());
  runApp(MyApp());
}
