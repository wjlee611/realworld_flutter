import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:real_world/bloc/authentication/auth_bloc.dart';
import 'package:real_world/bloc/authentication/auth_event.dart';
import 'package:real_world/bloc/authentication/auth_state.dart';
import 'package:real_world/bloc/setting/setting_bloc.dart';
import 'package:real_world/bloc/setting/setting_event.dart';
import 'package:real_world/bloc/setting/setting_state.dart';
import 'package:real_world/common/enum/common_status_enum.dart';
import 'package:real_world/common/widgets/app_font.dart';
import 'package:real_world/common/widgets/common_text_form_widget.dart';
import 'package:real_world/constants/gaps.dart';
import 'package:real_world/constants/sizes.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SettingBloc, SettingState>(
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
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Updated!'),
              ));
            }
          },
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthUnknownState) {
              context.pop();
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const AppFont('Setting'),
          actions: const [],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size20,
          ),
          child: Column(
            children: [
              Gaps.v10,
              CommonTextForm(
                hint: 'Username',
                onChange: (value) {
                  context.read<SettingBloc>().add(SettingChangeUsername(value));
                },
                initialValue: context.read<SettingBloc>().state.username,
              ),
              Gaps.v10,
              CommonTextForm(
                hint: 'Email',
                onChange: (value) {
                  context.read<SettingBloc>().add(SettingChangeEmail(value));
                },
                initialValue: context.read<SettingBloc>().state.email,
              ),
              Gaps.v10,
              CommonTextForm(
                hint: 'Password',
                onChange: (value) {
                  context.read<SettingBloc>().add(SettingChangePassword(value));
                },
              ),
              Gaps.v10,
              CommonTextForm(
                hint: 'Bio',
                onChange: (value) {
                  context.read<SettingBloc>().add(SettingChangeBio(value));
                },
                initialValue: context.read<SettingBloc>().state.bio,
              ),
              Gaps.v10,
              FilledButton(
                onPressed: () {
                  context.read<SettingBloc>().add(SettingConfirm());
                },
                child: const AppFont(
                  'Update profile',
                ),
              ),
              FilledButton(
                onPressed: () => context.read<AuthBloc>().add(AuthLogout()),
                child: const AppFont(
                  'Sign out',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
