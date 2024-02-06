abstract class WriteArticleEvent {}

class WriteArticleChangeTitle extends WriteArticleEvent {
  final String title;

  WriteArticleChangeTitle(this.title);
}

class WriteArticleChangeDescription extends WriteArticleEvent {
  final String description;

  WriteArticleChangeDescription(this.description);
}

class WriteArticleChangeBody extends WriteArticleEvent {
  final String body;

  WriteArticleChangeBody(this.body);
}

class WriteArticleChangeAddTag extends WriteArticleEvent {
  final String tag;

  WriteArticleChangeAddTag(this.tag);
}

class WriteArticleChangeRemoveTag extends WriteArticleEvent {
  final String tag;

  WriteArticleChangeRemoveTag(this.tag);
}

class WriteArticleUpload extends WriteArticleEvent {}
