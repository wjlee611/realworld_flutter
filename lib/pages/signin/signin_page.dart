import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_world/common/widgets/app_font.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  void _signup(BuildContext context) {
    context.replace('/signup');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppFont('Sign in'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () => _signup(context),
            child: const AppFont('Need an account?'),
          ),
        ],
      ),
    );
  }
}
