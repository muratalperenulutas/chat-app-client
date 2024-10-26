import 'dart:convert';
import 'package:chat_app/config/url.dart';
import 'package:chat_app/models/login.dart';
import 'package:chat_app/models/register.dart';
import 'package:http/http.dart' as http;


class Api {

  static Future<http.Response> postRequest(String url, Map<String, dynamic> body) {
    return http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
  }

  static Future<http.Response> postLoginRequest(LoginModel loginModel) {
    return postRequest(Url.auth.Login, loginModel.toJson());
  }

  static Future<http.Response> postRegisterRequest(RegisterModel registerModel) {
    return postRequest(Url.auth.Register, registerModel.toJson());
  }
}