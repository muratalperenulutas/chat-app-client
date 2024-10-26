import 'dart:convert';
import 'dart:io';

import 'package:chat_app/models/login.dart';
import 'package:chat_app/models/register.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/services/api/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

class AuthService {
  static Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? refreshToken = await prefs.getString('refresh-token');

    if (refreshToken != null && refreshToken.length > 5) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> login(BuildContext context, LoginModel loginModel) async {
    try {
      final response = await Api.postLoginRequest(loginModel);

      if (response.statusCode == 200) {
        print(response.body);
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('refresh-token', jsonResponse['refreshToken']);
        String message = jsonResponse['message'];
        showSnackbar(context, message);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else if (response.statusCode == 401) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        String message = jsonResponse['message'];
        showSnackbar(context, message);
      } else {
        showSnackbar(context, 'Error');
        print('Login failed: ${response.body}');
      }
    } on SocketException catch (e2) {
      showSnackbar(context, 'No internet connection');
      print(e2);
    } catch (e) {
      print('Error: $e');
      showSnackbar(context, 'An error occurred');
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
        showSnackbar(context, message);
      } else if (response.statusCode == 401) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        String message = jsonResponse['message'];
        showSnackbar(context, message);
      } else {
        showSnackbar(context, 'Error');
        print('Register failed: ${response.body}');
      }
    } on SocketException catch (e2) {
      showSnackbar(context, 'No internet connection');
      print(e2);
    } catch (e) {
      print('Error: $e');
      showSnackbar(context, 'An error occurred');
    }
  }

  Future<void> logout() async {}
}
