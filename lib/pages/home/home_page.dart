import 'package:flutter/material.dart';
import 'package:real_world/bloc/authentication/auth_bloc.dart';
import 'package:real_world/bloc/authentication/auth_state.dart';
import 'package:real_world/bloc/signin/signin_bloc.dart';
import 'package:real_world/bloc/signin/signin_event.dart';
import 'package:real_world/common/widgets/app_font.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_world/constants/strings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _login(BuildContext context) {
    context.read<SinginBloc>().add(SigninConfirmEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppFont('Home'),
      ),
      body: Center(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticatedState) {
              return AppFont(state.user.token ?? Strings.nullStr);
            }
            return ElevatedButton(
              onPressed: () => _login(context),
              child: const AppFont('login'),
            );
          },
        ),
      ),
    );
  }
}
