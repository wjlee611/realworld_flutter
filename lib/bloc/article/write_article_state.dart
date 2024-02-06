import 'package:equatable/equatable.dart';
import 'package:real_world/common/enum/common_status_enum.dart';

class WriteArticleState extends Equatable {
  final ECommonStatus status;
  final String? title;
  final String? description;
  final String? body;
  final List<String> tagList;
  final String? message;

  const WriteArticleState({
    this.status = ECommonStatus.init,
    this.title,
    this.description,
    this.body,
    this.tagList = const [],
    this.message,
  });

  WriteArticleState copyWith({
    ECommonStatus? status,
    String? title,
    String? description,
    String? body,
    List<String>? tagList,
    String? message,
  }) =>
      WriteArticleState(
        status: status ?? this.status,
        title: title ?? this.title,
        description: description ?? this.description,
        body: body ?? this.body,
        tagList: tagList ?? this.tagList,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        status,
        title,
        description,
        body,
        tagList,
        message,
      ];
}
