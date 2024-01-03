import 'package:dio/dio.dart';
import 'package:real_world/interceptors/no_auth_interceptor.dart';
import 'package:real_world/models/article_model.dart';

class ArticleRepository {
  Future<ArticlesModel> getArticles({
    String? tag,
    String? author,
    String? favorited,
    int? limit,
    int? offset,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(NoAuthInterceptor());

    Map<String, dynamic> queryParams = {};
    if (tag != null) queryParams['tag'] = tag;
    if (author != null) queryParams['author'] = author;
    if (favorited != null) queryParams['favorited'] = favorited;
    if (limit != null) queryParams['limit'] = limit;
    if (offset != null) queryParams['offset'] = offset;

    var res = await dio.get(
      '/api/articles',
      queryParameters: queryParams,
    );

    return ArticlesModel.fromJson(res.data);
  }
}
