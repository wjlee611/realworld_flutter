import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:real_world/bloc/authentication/auth_bloc.dart';
import 'package:real_world/bloc/authentication/auth_event.dart';
import 'package:real_world/bloc/authentication/auth_state.dart';
import 'package:real_world/bloc/signin/signin_bloc.dart';
import 'package:real_world/bloc/signin/signin_event.dart';
import 'package:real_world/bloc/signin/signin_state.dart';
import 'package:real_world/common/enum/common_status_enum.dart';
import 'package:real_world/common/widgets/app_font.dart';
import 'package:real_world/common/widgets/common_text_form_widget.dart';
import 'package:real_world/constants/gaps.dart';
import 'package:real_world/constants/sizes.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SigninBloc, SigninState>(
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
          title: const AppFont('Sign in'),
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
                  context.replace('/register');
                },
                child: const AppFont('Need an account?'),
              ),
              CommonTextForm(
                hint: 'Email',
                onChange: (value) {
                  context.read<SigninBloc>().add(SigninChangeEmail(value));
                },
              ),
              Gaps.v10,
              CommonTextForm(
                hint: 'Password',
                onChange: (value) {
                  context.read<SigninBloc>().add(SigninChangePassword(value));
                },
              ),
              Gaps.v10,
              Align(
                alignment: Alignment.bottomRight,
                child: FilledButton(
                  onPressed: () {
                    if (context.read<SigninBloc>().state.status !=
                        ECommonStatus.loading) {
                      context.read<SigninBloc>().add(SigninConfirm());
                    }
                  },
                  child: const AppFont('Sign in'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
