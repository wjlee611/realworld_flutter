import 'package:equatable/equatable.dart';
import 'package:real_world/common/enum/common_status_enum.dart';
import 'package:real_world/models/user_model.dart';

class SignupState extends Equatable {
  final ECommonStatus status;
  final String? email;
  final String? password;
  final String? username;
  final UserModel? resUser;
  final String? message;

  const SignupState({
    this.status = ECommonStatus.init,
    this.email,
    this.password,
    this.username,
    this.resUser,
    this.message,
  });

  SignupState copyWith({
    ECommonStatus? status,
    String? email,
    String? password,
    String? username,
    UserModel? resUser,
    String? message,
  }) =>
      SignupState(
        status: status ?? this.status,
        email: email ?? this.email,
        password: password ?? this.password,
        username: username ?? this.username,
        resUser: resUser ?? this.resUser,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        status,
        email,
        password,
        username,
        resUser,
        message,
      ];
}
