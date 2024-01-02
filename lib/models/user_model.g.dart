// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      email: json['email'] as String?,
      token: json['token'] as String?,
      username: json['username'] as String?,
      bio: json['bio'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'email': instance.email,
      'token': instance.token,
      'username': instance.username,
      'bio': instance.bio,
      'image': instance.image,
    };
