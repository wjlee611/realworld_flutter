import 'package:equatable/equatable.dart';
import 'package:real_world/models/user_model.dart';

abstract class AuthState extends Equatable {}

class AuthInitState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthUnknownState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthAuthenticatedState extends AuthState {
  final UserModel user;

  AuthAuthenticatedState({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class AuthErrorState extends AuthState {
  final String message;

  AuthErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
