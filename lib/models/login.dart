class LoginModel{
  final String password;
  final String email;

  const LoginModel({required this.password, required this.email});

  Map<String,String> toJson() => {
    'email': email,
    'password': password,
  };
}