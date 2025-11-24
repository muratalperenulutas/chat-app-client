import 'package:auto_route/auto_route.dart';
import 'package:chat_app/core/router/app_router.dart';
import 'package:chat_app/features/auth/controllers/auth_controller.dart';
import 'package:chat_app/features/auth/models/register.dart';
import 'package:chat_app/features/auth/models/register_progress.dart';
import 'package:chat_app/features/auth/widgets/email_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen(authControllerProvider.select((s) => s.registerProgress), (previous, next) {
      if (next == RegisterProgress.email) {
        showEmailDialog(context, ref);
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
        usernameController.clear();
      } else if (next == RegisterProgress.completed) {
        context.router.replace(const LoginRoute());
        ref.read(authControllerProvider.notifier).setRegisterProgress(RegisterProgress.initial);
      }
    });

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
                            debugPrint("username empty");
                          }else if(passwordController.text.isEmpty&&confirmPasswordController.text.isEmpty){
                            debugPrint("password empty");
                          }else if(passwordController.text==confirmPasswordController.text) {
                            ref.read(authControllerProvider.notifier).register(
                                Register(
                                    password: passwordController.text,
                                    email: emailController.text,
                                    username: usernameController.text),
                                onSuccess: (msg) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
                                },
                                onError: (msg) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
                                }
                            );
                          }else{
                            debugPrint("passwords not match");
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
                context.router.replace(const LoginRoute());
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ]),
    );
  }
}
