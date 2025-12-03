import 'package:chat_app/config/environment.dart';

late Config appConfig;

class Url {
  static final auth = Auth();
  static String get websocket => appConfig.wsUrl;
}

class Auth{
  String get login => '${appConfig.apiUrl}/api/v1/auth/login';
  String get register => '${appConfig.apiUrl}/api/v1/auth/register';
  String get forgot => '${appConfig.apiUrl}/api/v1/auth/forgot-password';
  String get refresh => '${appConfig.apiUrl}/api/v1/auth/refresh';
}
