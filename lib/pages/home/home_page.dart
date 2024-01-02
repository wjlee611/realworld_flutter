import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_world/common/widgets/app_font.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _signin(BuildContext context) {
    context.push('/signin');
  }

  void _signup(BuildContext context) {
    context.push('/signup');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppFont('conduit'),
        actions: [
          TextButton(
            onPressed: () => _signin(context),
            child: const AppFont('Sign in'),
          ),
          TextButton(
            onPressed: () => _signup(context),
            child: const AppFont('Sign up'),
          ),
        ],
      ),
      body: const Center(
        child: AppFont('home'),
      ),
    );
  }
}
