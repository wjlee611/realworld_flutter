import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:real_world/interceptors/no_auth_interceptor.dart';
import 'package:real_world/models/user_model.dart';

class AuthRepository {
  Future<UserModel> postLogin({
    required String email,
    required String password,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(NoAuthInterceptor());

    Map<String, dynamic> body = {
      'user': {
        'email': email,
        'password': password,
      }
    };

    var res = await dio.post(
      '/api/users/login',
      data: jsonEncode(body),
    );

    return UserModel.fromJson(res.data);
  }

  Future<UserModel?> postRegistr({
    required String email,
    required String password,
    required String username,
  }) async {
    return null;
  }
}
