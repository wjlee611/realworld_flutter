import 'package:flutter/material.dart';
import 'package:real_world/common/widgets/app_font.dart';
import 'package:real_world/common/widgets/auth_actions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppFont('conduit'),
        actions: const [
          AuthActions(),
        ],
      ),
      body: const Center(
        child: AppFont('home'),
      ),
    );
  }
}
