import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_world/bloc/article/article_event.dart';
import 'package:real_world/bloc/article/article_state.dart';
import 'package:real_world/common/enum/common_status_enum.dart';
import 'package:real_world/repository/article_repository.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final String slug;
  final ArticleRepository articleRepository;

  ArticleBloc({
    required this.slug,
    required this.articleRepository,
  }) : super(const ArticleState()) {
    on<ArticleGetArticle>(_articleGetArticleHandler);
  }

  Future<void> _articleGetArticleHandler(
    ArticleGetArticle event,
    Emitter<ArticleState> emit,
  ) async {
    emit(state.copyWith(articleStatus: ECommonStatus.loading));
    try {
      var res = await articleRepository.getArticle(
        slug: slug,
      );

      emit(state.copyWith(
        articleStatus: ECommonStatus.loaded,
        article: res,
      ));
    } on DioException catch (e) {
      if (e.response != null) {
        emit(state.copyWith(
          articleStatus: ECommonStatus.error,
          message: e.response!.data.toString(),
        ));
      } else {
        emit(state.copyWith(
          articleStatus: ECommonStatus.error,
          message: e.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        articleStatus: ECommonStatus.error,
        message: e.toString(),
      ));
    }
  }
}
