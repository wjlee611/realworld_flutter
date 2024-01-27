import 'package:dio/dio.dart';
import 'package:real_world/interceptors/auth_interceptor.dart';
import 'package:real_world/interceptors/no_auth_interceptor.dart';
import 'package:real_world/models/comment_model.dart';

class CommentRepository {
  Future<List<CommentModel>> getComments({
    required String slug,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(NoAuthInterceptor());

    var res = await dio.get('/api/articles/$slug/comments');

    List<CommentModel> resList = [
      for (var comm in res.data['comments'] as List<dynamic>)
        CommentModel.fromJson(comm)
    ];

    return resList;
  }

  Future<CommentModel> addComments({
    required String slug,
    required String body,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());

    var res = await dio.post(
      '/api/articles/$slug/comments',
      data: {
        'comment': {
          'body': body,
        },
      },
    );

    return CommentModel.fromJson(res.data['comment']);
  }

  Future<bool> deleteComments({
    required String slug,
    required int id,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());

    await dio.delete('/api/articles/$slug/comments/$id');

    return true;
  }
}
