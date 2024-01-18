import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_world/bloc/article/article_event.dart';
import 'package:real_world/bloc/article/article_state.dart';
import 'package:real_world/common/enum/common_status_enum.dart';
import 'package:real_world/repository/article_repository.dart';
import 'package:real_world/repository/profile_repository.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final String slug;
  final ArticleRepository articleRepository;
  final ProfileRepository profileRepository;

  ArticleBloc({
    required this.slug,
    required this.articleRepository,
    required this.profileRepository,
  }) : super(const ArticleState()) {
    on<ArticleGetArticle>(_articleGetArticleHandler);
    on<ArticleFollowUser>(_articleFollowUserHandler);
    on<ArticleUnfollowUser>(_articleUnfollowUserHandler);
    on<ArticleFav>(_articleFavHandler);
    on<ArticleUnfav>(_articleUnfavHandler);
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

  Future<void> _articleFollowUserHandler(
    ArticleFollowUser event,
    Emitter<ArticleState> emit,
  ) async {
    if (state.article?.author?.username == null) return;

    emit(state.copyWith(articleStatus: ECommonStatus.loading));
    try {
      var res =
          await profileRepository.followUser(state.article!.author!.username!);

      emit(state.copyWith(
        articleStatus: ECommonStatus.loaded,
        article: state.article?.copyWithAuthor(
          author: res,
        ),
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

  Future<void> _articleUnfollowUserHandler(
    ArticleUnfollowUser event,
    Emitter<ArticleState> emit,
  ) async {
    if (state.article?.author?.username == null) return;

    emit(state.copyWith(articleStatus: ECommonStatus.loading));
    try {
      var res = await profileRepository
          .unfollowUser(state.article!.author!.username!);

      emit(state.copyWith(
        articleStatus: ECommonStatus.loaded,
        article: state.article?.copyWithAuthor(
          author: res,
        ),
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

  Future<void> _articleFavHandler(
    ArticleFav event,
    Emitter<ArticleState> emit,
  ) async {
    if (state.article!.slug == null) return;

    emit(state.copyWith(articleStatus: ECommonStatus.loading));
    try {
      var res = await articleRepository.favArticle(
        slug: state.article!.slug!,
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

  Future<void> _articleUnfavHandler(
    ArticleUnfav event,
    Emitter<ArticleState> emit,
  ) async {
    if (state.article!.slug == null) return;

    emit(state.copyWith(articleStatus: ECommonStatus.loading));
    try {
      var res = await articleRepository.unfavArticle(
        slug: state.article!.slug!,
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
