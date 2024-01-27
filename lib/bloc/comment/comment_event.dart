abstract class CommentEvent {}

class CommentGet extends CommentEvent {}

class CommentChange extends CommentEvent {
  final String value;

  CommentChange(this.value);
}

class CommentAdd extends CommentEvent {}

class CommentDelete extends CommentEvent {
  final int id;

  CommentDelete({required this.id});
}
