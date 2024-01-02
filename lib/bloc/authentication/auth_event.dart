import 'package:real_world/models/user_model.dart';

abstract class AuthEvent {}

class AuthLogin extends AuthEvent {
  UserModel user;

  AuthLogin({
    required this.user,
  });
}

class AuthLogout extends AuthEvent {}

class AuthGetCurrentUser extends AuthEvent {}
