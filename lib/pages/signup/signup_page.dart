import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:real_world/bloc/authentication/auth_bloc.dart';
import 'package:real_world/bloc/authentication/auth_event.dart';
import 'package:real_world/bloc/authentication/auth_state.dart';
import 'package:real_world/bloc/signup/signup_bloc.dart';
import 'package:real_world/bloc/signup/signup_event.dart';
import 'package:real_world/bloc/signup/signup_state.dart';
import 'package:real_world/common/enum/common_status_enum.dart';
import 'package:real_world/common/widgets/app_font.dart';
import 'package:real_world/constants/gaps.dart';
import 'package:real_world/constants/sizes.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state.status == ECommonStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message ?? 'error'),
              ));
            }
            if (state.status == ECommonStatus.loaded) {
              context.read<AuthBloc>().add(AuthLogin(
                    user: state.resUser!,
                  ));
            }
          },
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticatedState) {
              context.pop();
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const AppFont('Sign up'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  context.replace('/login');
                },
                child: const AppFont('Have an account?'),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: Sizes.size1,
                    horizontal: Sizes.size10,
                  ),
                  hintText: 'Username',
                  border: OutlineInputBorder(),
                ),
                onTapOutside: (_) {
                  FocusScope.of(context).unfocus();
                },
                onChanged: (value) {
                  context.read<SignupBloc>().add(SignupChangeUsername(value));
                },
              ),
              Gaps.v10,
              TextFormField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: Sizes.size1,
                    horizontal: Sizes.size10,
                  ),
                  hintText: 'Email',
                  border: OutlineInputBorder(),
                ),
                onTapOutside: (_) {
                  FocusScope.of(context).unfocus();
                },
                onChanged: (value) {
                  context.read<SignupBloc>().add(SignupChangeEmail(value));
                },
              ),
              Gaps.v10,
              TextFormField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: Sizes.size1,
                    horizontal: Sizes.size10,
                  ),
                  hintText: 'Password',
                  border: OutlineInputBorder(),
                ),
                onTapOutside: (_) {
                  FocusScope.of(context).unfocus();
                },
                onChanged: (value) {
                  context.read<SignupBloc>().add(SignupChangePassword(value));
                },
              ),
              Gaps.v10,
              Align(
                alignment: Alignment.bottomRight,
                child: FilledButton(
                  onPressed: () {
                    if (context.read<SignupBloc>().state.status !=
                        ECommonStatus.loading) {
                      context.read<SignupBloc>().add(SignupConfirm());
                    }
                  },
                  child: const AppFont('Sign up'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
