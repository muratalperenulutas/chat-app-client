import 'package:auto_route/auto_route.dart';
import 'package:chat_app/core/router/app_router.dart';
import 'package:chat_app/core/services/notification/notification_service.dart';
import 'package:chat_app/features/auth/controllers/auth_controller.dart';
import 'package:chat_app/features/auth/models/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final identifierController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                        const Text("Login", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        const Text("Sign in to your account", style: TextStyle(fontSize: 14, color: Colors.grey)),
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
          controller: identifierController,
          decoration: const InputDecoration(
            labelText: "Email or username",
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
        TextButton(
          onPressed: () {},
          child: const Text("Forgot password?"),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              final login = Login(identifier: identifierController.text, password: passwordController.text);
              ref.read(authControllerProvider.notifier).login(
                login,
                onSuccess: () {
                  context.router.replace(const HomeRoute());
                  try {
                    NotificationService.instance.initialize();
                    debugPrint('Notification service initialized successfully');
                  } catch (e) {
                    debugPrint('Notification service initialization error: $e');
                  }
                },
                onError: (msg) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text(
              "Login",
              style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Do Not Have An Account?",
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                context.router.replace(const RegisterRoute());
              },
              child: const Text("Register"),
            ),
          ],
        ),
      ],
    );
  }
}
