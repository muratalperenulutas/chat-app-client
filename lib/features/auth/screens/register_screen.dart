import 'package:chat_app/features/auth/controllers/auth_controller.dart';
import 'package:chat_app/features/auth/models/register.dart';
import 'package:chat_app/features/auth/models/register_progress.dart';
import 'package:chat_app/features/auth/services/auth.dart';
import 'package:chat_app/features/auth/widgets/email_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  final AuthController authController=Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    ever(authController.registerProgress, (RegisterProgress progress){
      if(progress==RegisterProgress.EMAIL){
        showEmailDialog(context);
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
        usernameController.clear();
      }else if(progress==RegisterProgress.COMPLETED){
        Get.toNamed("/login");
        authController.setRegisterProgress(RegisterProgress.INITIAL);
      }
    });
  }

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
                        onPressed: () async {
                          if(usernameController.text.isEmpty){
                            print("username empty");
                          }else if(passwordController.text.isEmpty&&confirmPasswordController.text.isEmpty){
                            print("password empty");
                          }else if(passwordController.text==confirmPasswordController.text) {
                            await AuthService.register(context, RegisterModel(
                                password: passwordController.text,
                                email: emailController.text,
                                username: usernameController.text));
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
                Get.toNamed('/login');
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ]),
    );
  }
}
