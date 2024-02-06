import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_world/bloc/article/write_article_event.dart';
import 'package:real_world/bloc/article/write_article_state.dart';
import 'package:real_world/common/enum/common_status_enum.dart';
import 'package:real_world/repository/article_repository.dart';

class WriteArticleBloc extends Bloc<WriteArticleEvent, WriteArticleState> {
  final ArticleRepository articleRepository;

  WriteArticleBloc({
    required this.articleRepository,
  }) : super(const WriteArticleState()) {
    on<WriteArticleChangeTitle>(_writeArticleChangeTitleHandler);
    on<WriteArticleChangeDescription>(_writeArticleChangeDescriptionHandler);
    on<WriteArticleChangeBody>(_writeArticleChangeBodyHandler);
    on<WriteArticleChangeAddTag>(_writeArticleChangeAddTagHandler);
    on<WriteArticleChangeRemoveTag>(_writeArticleChangeRemoveTagHandler);
    on<WriteArticleUpload>(_writeArticleUploadHandler);
  }

  Future<void> _writeArticleChangeTitleHandler(
    WriteArticleChangeTitle event,
    Emitter<WriteArticleState> emit,
  ) async {
    emit(state.copyWith(title: event.title));
  }

  Future<void> _writeArticleChangeDescriptionHandler(
    WriteArticleChangeDescription event,
    Emitter<WriteArticleState> emit,
  ) async {
    emit(state.copyWith(description: event.description));
  }

  Future<void> _writeArticleChangeBodyHandler(
    WriteArticleChangeBody event,
    Emitter<WriteArticleState> emit,
  ) async {
    emit(state.copyWith(body: event.body));
  }

  Future<void> _writeArticleChangeAddTagHandler(
    WriteArticleChangeAddTag event,
    Emitter<WriteArticleState> emit,
  ) async {
    if (state.tagList.contains(event.tag)) return;
    List<String> newList = [];
    newList
      ..addAll(state.tagList)
      ..add(event.tag);
    emit(state.copyWith(tagList: newList));
  }

  Future<void> _writeArticleChangeRemoveTagHandler(
    WriteArticleChangeRemoveTag event,
    Emitter<WriteArticleState> emit,
  ) async {
    List<String> newList = [];
    for (var tag in state.tagList) {
      if (tag != event.tag) newList.add(tag);
    }
    emit(state.copyWith(tagList: newList));
  }

  Future<void> _writeArticleUploadHandler(
    WriteArticleUpload event,
    Emitter<WriteArticleState> emit,
  ) async {
    // Validation
    if (state.title == null || state.title?.isEmpty == true) {
      emit(state.copyWith(
        status: ECommonStatus.error,
        message: 'Title is required.',
      ));
      emit(state.copyWith(status: ECommonStatus.init));
      return;
    }
    if (state.description == null || state.description?.isEmpty == true) {
      emit(state.copyWith(
        status: ECommonStatus.error,
        message: 'Description is required.',
      ));
      emit(state.copyWith(status: ECommonStatus.init));
      return;
    }
    if (state.body == null || state.body?.isEmpty == true) {
      emit(state.copyWith(
        status: ECommonStatus.error,
        message: 'Body is required.',
      ));
      emit(state.copyWith(status: ECommonStatus.init));
      return;
    }

    emit(state.copyWith(status: ECommonStatus.loading));
    try {
      var res = await articleRepository.createArticle(
        title: state.title!,
        description: state.description!,
        body: state.body!,
        tagList: state.tagList,
      );

      print(res);

      emit(state.copyWith(status: ECommonStatus.loaded));
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
      emit(state.copyWith(status: ECommonStatus.init));
    } catch (e) {
      emit(state.copyWith(
        status: ECommonStatus.error,
        message: e.toString(),
      ));
      emit(state.copyWith(status: ECommonStatus.init));
    }
  }
}
