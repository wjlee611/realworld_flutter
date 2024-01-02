import 'package:equatable/equatable.dart';
import 'package:real_world/common/enum/common_status_enum.dart';
import 'package:real_world/models/user_model.dart';

class SigninState extends Equatable {
  final ECommonStatus status;
  final String? email;
  final String? password;
  final UserModel? user;
  final String? message;

  const SigninState({
    this.status = ECommonStatus.init,
    this.email = 'wjlee611@gmail.com',
    this.password = "Qqwe123!",
    this.user,
    this.message,
  });

  SigninState copyWith({
    ECommonStatus? status,
    String? email,
    String? password,
    UserModel? user,
    String? message,
  }) =>
      SigninState(
        status: status ?? this.status,
        email: email ?? this.email,
        password: password ?? this.password,
        user: user ?? this.user,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        status,
        email,
        password,
        user,
        message,
      ];
}
