import 'package:equatable/equatable.dart';
import 'package:real_world/common/enum/common_status_enum.dart';
import 'package:real_world/models/article_model.dart';

class ArticleState extends Equatable {
  final ECommonStatus articleStatus;
  final ECommonStatus commentStatus;
  final ArticleModel? article;
  final String? message;

  const ArticleState({
    this.articleStatus = ECommonStatus.init,
    this.commentStatus = ECommonStatus.init,
    this.article,
    this.message,
  });

  ArticleState copyWith({
    ECommonStatus? articleStatus,
    ECommonStatus? commentStatus,
    ArticleModel? article,
    String? message,
  }) =>
      ArticleState(
        articleStatus: articleStatus ?? this.articleStatus,
        commentStatus: commentStatus ?? this.commentStatus,
        article: article ?? this.article,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        articleStatus,
        commentStatus,
        article,
        message,
      ];
}
