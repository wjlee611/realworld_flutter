import 'package:dio/dio.dart';
import 'package:real_world/constants/end_points.dart';

class NoAuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // base url 설정
    options.baseUrl = EndPoints.realworld;

    // 기타 헤더 작성
    options.headers['X-Requested-With'] = 'XMLHttpRequest';
    options.headers['Content-Type'] = 'application/json';

    return handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    // Logging
    print(
      '[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}',
    );
    return handler.next(response);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Logging
    print(
      '[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}',
    );
    print(
      '[ERR] code: ${err.response?.statusCode}',
    );

    return handler.next(err);
  }
}
