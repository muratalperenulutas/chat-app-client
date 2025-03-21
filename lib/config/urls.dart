String address1 = "http://localhost:8090";
String address2 = "http://10.0.2.2:8090";
String address3 = "ws://10.0.2.2:9004/ws";
String address4 = "https://example.com";

String serverAddress = address4;
String websocketAddress = address3;

class Url {
  static final auth = Auth();
  static final websocket =websocketAddress;
}

class Auth{
  String Login = '$serverAddress/api/v1/auth/login';
  String Register = '$serverAddress/api/v1/auth/register';
  String Forgot = '$serverAddress/api/v1/auth/forgot-password';
  String Refresh = '$serverAddress/api/v1/auth/refresh';
}