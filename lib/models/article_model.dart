import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:real_world/models/profile_model.dart';
import 'package:real_world/utils/datetime_parser.dart';

part 'article_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ArticlesModel extends Equatable {
  final List<ArticleModel> articles;
  final int articlesCount;

  const ArticlesModel({
    this.articles = const [],
    this.articlesCount = 0,
  });

  factory ArticlesModel.fromJson(Map<String, dynamic> json) =>
      _$ArticlesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticlesModelToJson(this);

  @override
  List<Object?> get props => [
        articles,
        articlesCount,
      ];
}

@JsonSerializable(explicitToJson: true)
class ArticleModel extends Equatable {
  final String? slug;
  final String? title;
  final String? description;
  final String? body;
  final List<String>? tagList;
  @JsonKey(fromJson: strToDt)
  final DateTime? createdAt;
  @JsonKey(fromJson: strToDt)
  final DateTime? updatedAt;
  final bool? favorited;
  final int? favoritesCount;
  final ProfileModel? author;

  const ArticleModel({
    this.slug,
    this.title,
    this.description,
    this.body,
    this.tagList,
    this.createdAt,
    this.updatedAt,
    this.favorited,
    this.favoritesCount,
    this.author,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);

  ArticleModel copyWithAuthor({
    ProfileModel? author,
  }) =>
      ArticleModel(
        slug: slug,
        title: title,
        description: description,
        body: body,
        tagList: tagList,
        createdAt: createdAt,
        updatedAt: updatedAt,
        favorited: favorited,
        favoritesCount: favoritesCount,
        author: author ?? this.author,
      );

  @override
  List<Object?> get props => [
        slug,
        title,
        description,
        body,
        tagList,
        createdAt,
        updatedAt,
        favorited,
        favoritesCount,
        author,
      ];
}
