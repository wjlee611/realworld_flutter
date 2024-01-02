import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:real_world/bloc/authentication/auth_bloc.dart';
import 'package:real_world/bloc/authentication/auth_event.dart';
import 'package:real_world/bloc/authentication/auth_state.dart';
import 'package:real_world/common/widgets/app_font.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnknownState) {
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const AppFont('Setting'),
          actions: const [],
        ),
        body: Column(
          children: [
            FilledButton(
              onPressed: () => context.read<AuthBloc>().add(AuthLogout()),
              child: const AppFont(
                'Sign out',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
