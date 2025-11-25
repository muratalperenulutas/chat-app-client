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

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
            return Center(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(24),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Register", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        const Text("Create your account", style: TextStyle(fontSize: 14, color: Colors.grey)),
                        const SizedBox(height: 32),
                        _buildFormContent(context),
                      ],
                    ),
                  ),
                ),
              ),
            );
          
        },
      ),
    );
  }

  Widget _buildFormContent(BuildContext context) {
    return Column(
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
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: "Email",
            labelStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          obscureText: true,
          controller: passwordController,
          decoration: const InputDecoration(
            labelText: "Password",
            labelStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          obscureText: true,
          controller: confirmPasswordController,
          decoration: const InputDecoration(
            labelText: "Confirm Password",
            labelStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              if (usernameController.text.isEmpty) {
                debugPrint("username empty");
              } else if (passwordController.text.isEmpty && confirmPasswordController.text.isEmpty) {
                debugPrint("password empty");
              } else if (passwordController.text == confirmPasswordController.text) {
                ref.read(authControllerProvider.notifier).register(
                  Register(
                    password: passwordController.text,
                    email: emailController.text,
                    username: usernameController.text,
                  ),
                  onSuccess: (msg) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
                  },
                  onError: (msg) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
                  },
                );
              } else {
                debugPrint("passwords not match");
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text(
              "Register",
              style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Already have an account?",
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 4),
            TextButton(
              onPressed: () {
                context.router.replace(const LoginRoute());
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ],
    );
  }
}
