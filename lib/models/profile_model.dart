import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel extends Equatable {
  final String? username;
  final String? bio;
  final String? image;
  final bool? following;

  const ProfileModel({
    this.username,
    this.bio,
    this.image,
    this.following,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

  @override
  List<Object?> get props => [
        username,
        bio,
        image,
        following,
      ];
}
