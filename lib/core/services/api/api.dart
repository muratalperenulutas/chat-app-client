import 'dart:convert';
import 'package:chat_app/config/urls.dart';
import 'package:chat_app/features/auth/models/login.dart';
import 'package:chat_app/features/auth/models/register.dart';
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

  static Future<http.Response> postLoginRequest(Login login) {
    return postRequest(Url.auth.login, login.toJson());
  }

  static Future<http.Response> postRegisterRequest(Register register) {
    return postRequest(Url.auth.register, register.toJson());
  }
  static Future<http.Response> postRefreshRequest(String refreshToken) {
    return postRequest(
        Url.auth.refresh,
        {
          'refreshToken': refreshToken,
        }
  );
  }
}