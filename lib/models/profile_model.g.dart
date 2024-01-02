// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      username: json['username'] as String?,
      bio: json['bio'] as String?,
      image: json['image'] as String?,
      following: json['following'] as bool?,
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'bio': instance.bio,
      'image': instance.image,
      'following': instance.following,
    };
