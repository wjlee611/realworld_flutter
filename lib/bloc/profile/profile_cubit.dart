import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_world/common/enum/common_status_enum.dart';
import 'package:real_world/models/profile_model.dart';
import 'package:real_world/repository/profile_repository.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileRepository profileRepository;

  ProfileCubit({
    required this.profileRepository,
  }) : super(const ProfileState());

  void getProfile(String username) async {
    emit(state.copyWith(status: ECommonStatus.loading));
    try {
      var res = await profileRepository.getProfile(username);

      emit(state.copyWith(
        status: ECommonStatus.loaded,
        profile: res,
      ));
    } on DioException catch (e) {
      if (e.response != null) {
        emit(state.copyWith(
          status: ECommonStatus.error,
          message: e.response!.data.toString(),
        ));
      } else {
        emit(state.copyWith(
          status: ECommonStatus.error,
          message: e.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: ECommonStatus.error,
        message: e.toString(),
      ));
    }
  }

  void followUser() async {
    if (state.profile?.username == null) return;

    emit(state.copyWith(status: ECommonStatus.loading));
    try {
      var res = await profileRepository.followUser(state.profile!.username!);

      emit(state.copyWith(
        status: ECommonStatus.loaded,
        profile: res,
      ));
    } on DioException catch (e) {
      if (e.response != null) {
        emit(state.copyWith(
          status: ECommonStatus.error,
          message: e.response!.data.toString(),
        ));
      } else {
        emit(state.copyWith(
          status: ECommonStatus.error,
          message: e.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: ECommonStatus.error,
        message: e.toString(),
      ));
    }
  }

  void unfollowUser() async {
    if (state.profile?.username == null) return;

    emit(state.copyWith(status: ECommonStatus.loading));
    try {
      var res = await profileRepository.unfollowUser(state.profile!.username!);

      emit(state.copyWith(
        status: ECommonStatus.loaded,
        profile: res,
      ));
    } on DioException catch (e) {
      if (e.response != null) {
        emit(state.copyWith(
          status: ECommonStatus.error,
          message: e.response!.data.toString(),
        ));
      } else {
        emit(state.copyWith(
          status: ECommonStatus.error,
          message: e.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: ECommonStatus.error,
        message: e.toString(),
      ));
    }
  }
}

class ProfileState extends Equatable {
  final ECommonStatus status;
  final ProfileModel? profile;
  final String? message;

  const ProfileState({
    this.status = ECommonStatus.init,
    this.profile,
    this.message,
  });

  ProfileState copyWith({
    ECommonStatus? status,
    ProfileModel? profile,
    String? message,
  }) =>
      ProfileState(
        status: status ?? this.status,
        profile: profile ?? this.profile,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        status,
        profile,
        message,
      ];
}
