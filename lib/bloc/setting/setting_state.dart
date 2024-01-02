import 'package:equatable/equatable.dart';
import 'package:real_world/common/enum/common_status_enum.dart';
import 'package:real_world/models/user_model.dart';

class SettingState extends Equatable {
  final ECommonStatus status;
  final String? username;
  final String? email;
  final String? password;
  final String? bio;
  final UserModel? resUser;
  final String? message;

  const SettingState({
    this.status = ECommonStatus.init,
    this.username,
    this.email,
    this.password,
    this.bio,
    this.resUser,
    this.message,
  });

  SettingState copyWith({
    ECommonStatus? status,
    String? username,
    String? email,
    String? password,
    String? bio,
    UserModel? resUser,
    String? message,
  }) =>
      SettingState(
        status: status ?? this.status,
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        bio: bio ?? this.bio,
        resUser: resUser ?? this.resUser,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        status,
        username,
        email,
        password,
        bio,
        resUser,
        message,
      ];
}
