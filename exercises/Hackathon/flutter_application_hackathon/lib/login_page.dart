import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      // 直接用 FirebaseAuth 调 Google 登录（不需要 GoogleSignIn 插件）
      final provider = GoogleAuthProvider();

      await FirebaseAuth.instance.signInWithProvider(provider);

      // 登录成功后，跳转到 Quiz 页面
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, "/quiz");
      }
    } catch (e) {
      debugPrint("Google sign-in error: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => _signInWithGoogle(context),
          child: const Text("Sign in with Google"),
        ),
      ),
    );
  }
}
