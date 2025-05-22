import 'dart:convert';
import 'dart:io';

import 'package:chat_app/constants/enums/source_enum.dart';
import 'package:chat_app/data/person/person.dart';
import 'package:chat_app/data/person/person_repository.dart';
import 'package:chat_app/data/person/person_service.dart';
import 'package:chat_app/features/auth/controllers/auth_controller.dart';
import 'package:chat_app/features/auth/models/login.dart';
import 'package:chat_app/features/auth/models/register.dart';
import 'package:chat_app/core/services/api/api.dart';
import 'package:chat_app/features/auth/models/register_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

class AuthService extends GetxService{
  static AuthController authController = Get.find<AuthController>();

  static Future<void> login(BuildContext context, Login login) async {
    print("Login");
    try {
      final response = await Api.postLoginRequest(login);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      String message = jsonResponse['message'];

      if (response.statusCode == 200) {
        String accessToken = jsonResponse['accessToken'];
        String refreshToken = jsonResponse['refreshToken'];

        if (JwtDecoder.isExpired(refreshToken) ||
            JwtDecoder.isExpired(accessToken)) {
          print('Token expired');
        } else {
          //order is important (race condition)
          authController.setAccessToken(accessToken);
          authController.setRefreshToken(refreshToken);
          authController.setLoggedIn();
          Get.offNamed('/home');

          Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
          print('Decoded Token: $decodedToken');
          String userId=decodedToken["sub"];
          authController.setUserId(userId);
          //Person person=Person(source: SourceEnum.SERVER,personId:userId );
          //Get.find<PersonRepository>().insertPerson(person);
        }
        //showSnackBar(context, message);
      } else if (response.statusCode == 401) {
        showSnackBar(context, message);
      } else {
        showSnackBar(context, message);
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
      BuildContext context, Register register) async {
    print("Register");
    try {
      final response = await Api.postRegisterRequest(register);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      String message = jsonResponse['message'];
      print(jsonResponse);
      if (response.statusCode == 201) {
        showSnackBar(context, message);
        authController.setRegisterProgress(RegisterProgress.EMAIL);
      } else if (response.statusCode == 400) {
        showSnackBar(context, message);
      } else {
        showSnackBar(context, message);
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

  static Future<void> refresh() async {
    print("Refresh");
    try {
      final response =
          await Api.postRefreshRequest(authController.refreshToken.value);

      if (response.statusCode == 200) {
        //print(response.body);
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        //print(jsonResponse);
        print(jsonResponse['message']);
        authController.setAccessToken(jsonResponse['accessToken']);
      } else if (response.statusCode == 401) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        String message = jsonResponse['message'];
        print(message);
        authController.logout();
      } else {
        print('Refresh failed: ${response.body}');
      }
    } on SocketException catch (e2) {
      print('No internet connection');
      print(e2);
    } catch (e) {
      print('Error: $e');
    }
  }
}
