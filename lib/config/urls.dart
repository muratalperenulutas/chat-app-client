String address1 = "http://localhost:8090";
String address2 = "http://10.0.2.2:8090";
String address3 = "ws://10.0.2.2:9004/ws";
String address4 = "https://example.com";
String address5 = "wss://example.com/ws";

String authAddress = address4;
String websocketAddress = address5;

class Url {
  static final auth = Auth();
  static final websocket =websocketAddress;
}

class Auth{
  String login = '$authAddress/api/v1/auth/login';
  String register = '$authAddress/api/v1/auth/register';
  String forgot = '$authAddress/api/v1/auth/forgot-password';
  String refresh = '$authAddress/api/v1/auth/refresh';
}