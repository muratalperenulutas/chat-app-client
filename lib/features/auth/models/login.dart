class Login{
  final String password;
  final String identifier;

  const Login({required this.password, required this.identifier});

  Map<String,String> toJson() => {
    'identifier': identifier,
    'password': password,
  };
}