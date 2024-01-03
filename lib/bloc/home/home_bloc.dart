import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_world/bloc/home/home_event.dart';
import 'package:real_world/bloc/home/home_state.dart';
import 'package:real_world/common/enum/common_status_enum.dart';
import 'package:real_world/constants/strings.dart';
import 'package:real_world/repository/article_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  static const int limit = 10;

  final ArticleRepository articleRepository;

  HomeBloc({
    required this.articleRepository,
  }) : super(const HomeState()) {
    on<HomeChangeTag>(_homeChangeTagHandler);
    on<HomeGetArticles>(_homeGetArticlesHandler);

    add(HomeGetArticles());
  }

  Future<void> _homeChangeTagHandler(
    HomeChangeTag event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(tag: event.tag));
    _homeGetArticlesHandler(HomeGetArticles(), emit);
  }

  Future<void> _homeGetArticlesHandler(
    HomeGetArticles event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: ECommonStatus.loading));
    try {
      var res = await articleRepository.getArticles(
        author: event.author,
        favorited: event.favorited,
        limit: limit,
        offset: event.offset,
        tag: state.tag == Strings.nullStr ? null : state.tag,
      );

      emit(state.copyWith(
        status: ECommonStatus.loaded,
        articles: res,
      ));
    } on DioException catch (e) {
      if (e.response != null) {
        emit(state.copyWith(
          status: ECommonStatus.error,
          message: e.response!.data.toString(),
        ));
      } else {
        emit(state.copyWith(
          status: ECommonStatus.error,
          message: e.message,
        ));
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(
        status: ECommonStatus.error,
        message: e.toString(),
      ));
    }
  }
}
