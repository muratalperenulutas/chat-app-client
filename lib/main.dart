import 'package:chat_app/app.dart';
import 'package:chat_app/services/auth/auth.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isLoggedIn = await AuthService.isUserLoggedIn();
  runApp(MyApp(isLoggedIn:isLoggedIn ));
}


