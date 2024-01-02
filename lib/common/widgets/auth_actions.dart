import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:real_world/bloc/authentication/auth_bloc.dart';
import 'package:real_world/bloc/authentication/auth_event.dart';
import 'package:real_world/bloc/authentication/auth_state.dart';
import 'package:real_world/common/widgets/app_font.dart';
import 'package:real_world/constants/sizes.dart';
import 'package:real_world/constants/strings.dart';

class AuthActions extends StatelessWidget {
  const AuthActions({super.key});

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
          return Row(
            children: [
              IconButton(
                onPressed: () => context.push('/setting'),
                icon: Icon(
                  Icons.settings,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              TextButton(
                onPressed: () =>
                    context.push('/profile/${state.user.username}'),
                child: AppFont(state.user.username ?? Strings.nullStr),
              ),
            ],
          );
        }
        return Row(
          children: [
            TextButton(
              onPressed: () => context.push('/login'),
              child: const AppFont('Sign in'),
            ),
            TextButton(
              onPressed: () => context.push('/register'),
              child: const AppFont('Sign up'),
            ),
          ],
        );
      },
    );
  }
}
