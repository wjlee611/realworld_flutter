import 'package:equatable/equatable.dart';
import 'package:real_world/common/enum/common_status_enum.dart';
import 'package:real_world/constants/strings.dart';
import 'package:real_world/models/article_model.dart';

class HomeState extends Equatable {
  final ECommonStatus status;
  final ArticlesModel articles;
  final int page;
  final String tag;
  final String? message;

  const HomeState({
    this.status = ECommonStatus.init,
    this.articles = const ArticlesModel(),
    this.page = 1,
    this.tag = Strings.nullStr,
    this.message,
  });

  HomeState copyWith({
    ECommonStatus? status,
    ArticlesModel? articles,
    int? page,
    String? tag,
    String? message,
  }) =>
      HomeState(
        status: status ?? this.status,
        articles: articles ?? this.articles,
        page: page ?? this.page,
        tag: tag ?? this.tag,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        status,
        articles,
        page,
        tag,
        message,
      ];
}
