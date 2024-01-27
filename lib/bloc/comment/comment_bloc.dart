import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_world/bloc/comment/comment_event.dart';
import 'package:real_world/bloc/comment/comment_state.dart';
import 'package:real_world/common/enum/common_status_enum.dart';
import 'package:real_world/repository/comment_repository.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository commentRepository;
  final String slug;

  CommentBloc({
    required this.commentRepository,
    required this.slug,
  }) : super(const CommentState()) {
    on<CommentGet>(_commentGetHandler);
    on<CommentChange>(_commentChangeHandler);
    on<CommentAdd>(_commentAddHandler);
    on<CommentDelete>(_commentDeleteHandler);

    add(CommentGet());
  }

  Future<void> _commentGetHandler(
    CommentGet event,
    Emitter<CommentState> emit,
  ) async {
    emit(state.copyWith(status: ECommonStatus.loading));
    try {
      var res = await commentRepository.getComments(
        slug: slug,
      );

      emit(state.copyWith(
        status: ECommonStatus.loaded,
        comments: res,
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
      emit(state.copyWith(
        status: ECommonStatus.error,
        message: e.toString(),
      ));
    }
  }

  Future<void> _commentChangeHandler(
    CommentChange event,
    Emitter<CommentState> emit,
  ) async {
    emit(state.copyWith(comment: event.value));
  }

  Future<void> _commentAddHandler(
    CommentAdd event,
    Emitter<CommentState> emit,
  ) async {
    if (state.comment == null || state.comment == '') return;

    emit(state.copyWith(status: ECommonStatus.loading));
    try {
      var res = await commentRepository.addComments(
        slug: slug,
        body: state.comment!,
      );

      emit(state.copyWith(
        status: ECommonStatus.loaded,
        comments: List.from(state.comments)..addAll([res]),
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
      emit(state.copyWith(
        status: ECommonStatus.error,
        message: e.toString(),
      ));
    }
  }

  Future<void> _commentDeleteHandler(
    CommentDelete event,
    Emitter<CommentState> emit,
  ) async {
    emit(state.copyWith(status: ECommonStatus.loading));
    try {
      var res = await commentRepository.deleteComments(
        slug: slug,
        id: event.id,
      );

      if (!res) throw Exception('Failed to delete comment');

      emit(state.copyWith(
        status: ECommonStatus.loaded,
        comments: List.from(state.comments)
          ..removeWhere((comment) => comment.id == event.id),
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
      emit(state.copyWith(
        status: ECommonStatus.error,
        message: e.toString(),
      ));
    }
  }
}
