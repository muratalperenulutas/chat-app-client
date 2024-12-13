import 'package:chat_app/models/register.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/services/auth/auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final usernameController = TextEditingController();

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
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [ Text("Register",style: TextStyle(fontSize: 28,color: Colors.white, fontWeight: FontWeight.w500),),],),
                SizedBox(height: 10,),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [ Text("Create your account",style: TextStyle(fontSize: 18,color: Colors.white, fontWeight: FontWeight.w500 ))],),
                
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
                  controller: usernameController,
                  decoration: const InputDecoration(
                      labelText: "Username",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black))),
                ),
                const SizedBox(height: 20),
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
                  obscureText: true,
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
                TextField(
                  obscureText: true,
                  controller: confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if(passwordController.text==confirmPasswordController.text) {
                            AuthService.register(context, RegisterModel(
                                password: passwordController.text,
                                email: emailController.text,
                                username: usernameController.text));
                            //show verification email send dialog
                            //open login page
                          }else{
                            print("passwords not match");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 12)),
                        child: const Text(
                          "Register",
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
              "Already have an account?",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(width: 4),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const LoginPage())));
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ]),
    );
  }
}
