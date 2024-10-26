class RegisterModel{
  final String email;
  final String password; 

  const RegisterModel({required this.password, required this.email});  

  Map<String,String> toJson() => {
    'email': email,
    'password': password
  };
}