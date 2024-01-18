import 'package:dio/dio.dart';
import 'package:real_world/interceptors/auth_interceptor.dart';
import 'package:real_world/interceptors/no_auth_interceptor.dart';
import 'package:real_world/models/profile_model.dart';

class ProfileRepository {
  Future<ProfileModel> getProfile(String username) async {
    Dio dio = Dio();
    dio.interceptors.add(NoAuthInterceptor());

    var res = await dio.get('/api/profiles/$username');

    return ProfileModel.fromJson(res.data['profile']);
  }

  Future<ProfileModel> followUser(String username) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());

    var res = await dio.post('/api/profiles/$username/follow');

    return ProfileModel.fromJson(res.data['profile']);
  }

  Future<ProfileModel> unfollowUser(String username) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());

    var res = await dio.delete('/api/profiles/$username/follow');

    return ProfileModel.fromJson(res.data['profile']);
  }
}
