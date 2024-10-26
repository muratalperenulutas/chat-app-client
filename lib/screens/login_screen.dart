import 'package:chat_app/models/login.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/services/auth/auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(padding: EdgeInsets.zero, children: [
        Container(
            color: Colors.green,
            height: screenHeight*0.25,
            child: const Padding(padding: EdgeInsets.all(25),
            child: Column(
              children: [
                SizedBox(height: 70),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [ Text("Login",style: TextStyle(fontSize: 28,color: Colors.white, fontWeight: FontWeight.w500),),],),
                SizedBox(height: 10,),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [ Text("Sign in to your account",style: TextStyle(fontSize: 18,color: Colors.white, fontWeight: FontWeight.w500 ))],),
                
              ],
            ),
            )),
        Form(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black))),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {},
                  child: const Text("Forgot password?"),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          AuthService.login(context, LoginModel(email: emailController.text,password: passwordController.text));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 12)),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                )
              ]),
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Do Not Have An Account?",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(width: 4),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const RegisterPage())));
              },
              child: const Text("Register"),
            ),
          ],
        ),
      ]),
    );
  }
}
