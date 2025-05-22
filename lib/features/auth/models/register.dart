class Register{
  final String email;
  final String password;
  final String username;

  const Register({required this.password, required this.email,required this.username});

  Map<String,String> toJson() => {
    'email': email,
    'username':username,
    'password': password
  };
}