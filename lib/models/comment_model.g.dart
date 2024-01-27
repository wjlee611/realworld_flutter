// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      id: json['id'] as int?,
      createdAt: strToDt(json['createdAt'] as String?),
      updatedAt: strToDt(json['updatedAt'] as String?),
      body: json['body'] as String?,
      author: json['author'] == null
          ? null
          : ProfileModel.fromJson(json['author'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'body': instance.body,
      'author': instance.author?.toJson(),
    };
