import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:real_world/models/profile_model.dart';
import 'package:real_world/utils/datetime_parser.dart';

part 'comment_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CommentModel extends Equatable {
  final int? id;
  @JsonKey(fromJson: strToDt)
  final DateTime? createdAt;
  @JsonKey(fromJson: strToDt)
  final DateTime? updatedAt;
  final String? body;
  final ProfileModel? author;

  const CommentModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.body,
    this.author,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
        body,
        author,
      ];
}
