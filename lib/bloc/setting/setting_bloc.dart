import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_world/bloc/setting/setting_event.dart';
import 'package:real_world/bloc/setting/setting_state.dart';
import 'package:real_world/common/enum/common_status_enum.dart';
import 'package:real_world/models/user_model.dart';
import 'package:real_world/repository/auth_repository.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final AuthRepository authRepository;

  SettingBloc({
    required this.authRepository,
    required UserModel user,
  }) : super(SettingState(
          username: user.username,
          email: user.email,
          bio: user.bio,
        )) {
    on<SettingChangeUsername>(_settingChangeUsernameHandler);
    on<SettingChangeEmail>(_settingChangeEmailHandler);
    on<SettingChangePassword>(_settingChangePasswordHandler);
    on<SettingChangeBio>(_settingChangeBioHandler);
    on<SettingConfirm>(_settingConfirmHandler);
  }

  Future<void> _settingChangeUsernameHandler(
    SettingChangeUsername event,
    Emitter<SettingState> emit,
  ) async {
    emit(state.copyWith(
      status: ECommonStatus.init,
      username: event.username,
    ));
  }

  Future<void> _settingChangeEmailHandler(
    SettingChangeEmail event,
    Emitter<SettingState> emit,
  ) async {
    emit(state.copyWith(
      status: ECommonStatus.init,
      email: event.email,
    ));
  }

  Future<void> _settingChangePasswordHandler(
    SettingChangePassword event,
    Emitter<SettingState> emit,
  ) async {
    emit(state.copyWith(
      status: ECommonStatus.init,
      password: event.password,
    ));
  }

  Future<void> _settingChangeBioHandler(
    SettingChangeBio event,
    Emitter<SettingState> emit,
  ) async {
    emit(state.copyWith(
      status: ECommonStatus.init,
      bio: event.bio,
    ));
  }

  Future<void> _settingConfirmHandler(
    SettingConfirm event,
    Emitter<SettingState> emit,
  ) async {
    emit(state.copyWith(status: ECommonStatus.loading));
    try {
      if (state.email == null || state.email!.isEmpty) {
        emit(state.copyWith(
          status: ECommonStatus.error,
          message: '이메일을 입력해주세요.',
        ));
        return;
      }

      if (state.password == null || state.password!.isEmpty) {
        emit(state.copyWith(
          status: ECommonStatus.error,
          message: '비밀번호를 입력해주세요.',
        ));
        return;
      }

      if (state.username == null || state.username!.isEmpty) {
        emit(state.copyWith(
          status: ECommonStatus.error,
          message: '이름을 입력해주세요.',
        ));
        return;
      }

      var res = await authRepository.updateUser(
        username: state.username!,
        email: state.email!,
        password: state.password!,
        bio: state.bio,
      );

      emit(state.copyWith(
        status: ECommonStatus.loaded,
        resUser: res,
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
