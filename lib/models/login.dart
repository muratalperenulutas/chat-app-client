class LoginModel{
  final String password;
  final String identifier;

  const LoginModel({required this.password, required this.identifier});

  Map<String,String> toJson() => {
    'identifier': identifier,
    'password': password,
  };
}