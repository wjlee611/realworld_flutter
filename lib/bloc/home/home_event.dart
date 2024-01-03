abstract class HomeEvent {}

class HomeGetTags extends HomeEvent {}

class HomeChangeTag extends HomeEvent {
  final String tag;

  HomeChangeTag(this.tag);
}

class HomeGetArticles extends HomeEvent {
  final String? author;
  final String? favorited;
  final int? page;

  HomeGetArticles({
    this.author,
    this.favorited,
    this.page,
  });
}
