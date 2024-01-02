import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final String? email;
  final String? token;
  final String? username;
  final String? bio;
  final String? image;

  const UserModel({
    this.email,
    this.token,
    this.username,
    this.bio,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [
        email,
        token,
        username,
        bio,
        image,
      ];
}
