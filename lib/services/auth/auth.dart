import 'dart:convert';
import 'dart:io';

import 'package:chat_app/controller/app_controller.dart';
import 'package:chat_app/models/login.dart';
import 'package:chat_app/models/register.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/services/api/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

class AuthService {
  static AppController appController = Get.find<AppController>();

  static Future<void> login(BuildContext context, LoginModel loginModel) async {
    try {
      final response = await Api.postLoginRequest(loginModel);

      if (response.statusCode == 200) {
        print(response.body);
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        appController.setRefreshToken(jsonResponse['refreshToken']);
        appController.setAccessToken(jsonResponse['accessToken']);
        String message = jsonResponse['message'];
        showSnackBar(context, message);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else if (response.statusCode == 401) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        String message = jsonResponse['message'];
        showSnackBar(context, message);
      } else {
        showSnackBar(context, 'Error');
        print('Login failed: ${response.body}');
      }
    } on SocketException catch (e2) {
      showSnackBar(context, 'No internet connection');
      print(e2);
    } catch (e) {
      print('Error: $e');
      showSnackBar(context, 'An error occurred');
    }
  }

  static Future<void> register(
      BuildContext context, RegisterModel registerModel) async {
    try {
      final response = await Api.postRegisterRequest(registerModel);

      if (response.statusCode == 201) {
        print(response.body);
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        String message = jsonResponse['message'];
        showSnackBar(context, message);
      } else if (response.statusCode == 401) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        String message = jsonResponse['message'];
        showSnackBar(context, message);
      } else {
        showSnackBar(context, 'Error');
        print('Register failed: ${response.body}');
      }
    } on SocketException catch (e2) {
      showSnackBar(context, 'No internet connection');
      print(e2);
    } catch (e) {
      print('Error: $e');
      showSnackBar(context, 'An error occurred');
    }
  }

  static Future<void> logout() async {
    appController.setAccessToken('');
    appController.setRefreshToken('');
  }
}
