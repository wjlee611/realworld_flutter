abstract class ArticleEvent {}

class ArticleGetArticle extends ArticleEvent {}

class ArticleFollowUser extends ArticleEvent {}

class ArticleUnfollowUser extends ArticleEvent {}

class ArticleFav extends ArticleEvent {}

class ArticleUnfav extends ArticleEvent {}
