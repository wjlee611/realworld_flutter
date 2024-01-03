import 'package:equatable/equatable.dart';
import 'package:real_world/common/enum/common_status_enum.dart';
import 'package:real_world/constants/strings.dart';
import 'package:real_world/models/article_model.dart';

class HomeState extends Equatable {
  final ECommonStatus status;
  final ArticlesModel articles;
  final List<String> tags;
  final int page;
  final String tag;
  final String? message;

  const HomeState({
    this.status = ECommonStatus.init,
    this.articles = const ArticlesModel(),
    this.tags = const [],
    this.page = 1,
    this.tag = Strings.nullStr,
    this.message,
  });

  HomeState copyWith({
    ECommonStatus? status,
    ArticlesModel? articles,
    List<String>? tags,
    int? page,
    String? tag,
    String? message,
  }) =>
      HomeState(
        status: status ?? this.status,
        articles: articles ?? this.articles,
        tags: tags ?? this.tags,
        page: page ?? this.page,
        tag: tag ?? this.tag,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        status,
        articles,
        tags,
        page,
        tag,
        message,
      ];
}
