import 'package:equatable/equatable.dart';
import 'package:real_world/common/enum/common_status_enum.dart';
import 'package:real_world/models/comment_model.dart';

class CommentState extends Equatable {
  final ECommonStatus status;
  final List<CommentModel> comments;
  final String? comment;
  final String? message;

  const CommentState({
    this.status = ECommonStatus.init,
    this.comments = const [],
    this.comment,
    this.message,
  });

  CommentState copyWith({
    ECommonStatus? status,
    List<CommentModel>? comments,
    String? comment,
    String? message,
  }) =>
      CommentState(
        status: status ?? this.status,
        comments: comments ?? this.comments,
        comment: comment ?? this.comment,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        status,
        comments,
        comment,
        message,
      ];
}
