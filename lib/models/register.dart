class RegisterModel{
  final String email;
  final String password;
  final String username;

  const RegisterModel({required this.password, required this.email,required this.username});

  Map<String,String> toJson() => {
    'email': email,
    'username':username,
    'password': password
  };
}