import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:real_world/bloc/authentication/auth_bloc.dart';
import 'package:real_world/bloc/authentication/auth_event.dart';
import 'package:real_world/bloc/authentication/auth_state.dart';
import 'package:real_world/common/widgets/app_font.dart';
import 'package:real_world/constants/sizes.dart';

class AuthActions extends StatelessWidget {
  const AuthActions({super.key});

  void _signin(BuildContext context) {
    context.push('/signin');
  }

  void _signup(BuildContext context) {
    context.push('/signup');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitState) {
          context.read<AuthBloc>().add(AuthGetCurrentUser());
        }
        if (state is AuthInitState) {
          return Container(
            width: Sizes.size24,
            height: Sizes.size24,
            margin: const EdgeInsets.only(right: Sizes.size20),
            child: const CircularProgressIndicator(),
          );
        }
        if (state is AuthAuthenticatedState) {
          return Padding(
            padding: const EdgeInsets.only(right: Sizes.size20),
            child: AppFont(state.user.username ?? ''),
          );
        }
        return Row(
          children: [
            TextButton(
              onPressed: () => _signin(context),
              child: const AppFont('Sign in'),
            ),
            TextButton(
              onPressed: () => _signup(context),
              child: const AppFont('Sign up'),
            ),
          ],
        );
      },
    );
  }
}
