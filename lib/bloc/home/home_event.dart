abstract class HomeEvent {}

class HomeChangeTag extends HomeEvent {
  final String tag;

  HomeChangeTag(this.tag);
}

class HomeGetArticles extends HomeEvent {
  final String? author;
  final String? favorited;
  final int? limit;
  final int? offset;

  HomeGetArticles({
    this.author,
    this.favorited,
    this.limit,
    this.offset,
  });
}
