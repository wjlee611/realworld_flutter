import 'package:real_world/bloc/authentication/auth_state.dart';

abstract class AuthEvent {}

class AuthChange extends AuthEvent {
  final AuthState state;

  AuthChange({
    required this.state,
  });
}
