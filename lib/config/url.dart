
String address1 = "https://";
String address2 = "http://localhost:8090";
String address3 = "http://10.0.2.2:8090";

String serverAddress = address3;

class Url {
  static final auth = Auth();
}

class Auth{
  String Login = '$serverAddress/auth/login';
  String Register = '$serverAddress/auth/register';
}