import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_world/bloc/signup/signup_event.dart';
import 'package:real_world/bloc/signup/signup_state.dart';
import 'package:real_world/common/enum/common_status_enum.dart';
import 'package:real_world/repository/auth_repository.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository authRepository;

  SignupBloc({
    required this.authRepository,
  }) : super(const SignupState()) {
    on<SignupChangeEmail>(_signupChangeEmailHandler);
    on<SignupChangePassword>(_signupChangePasswordHandler);
    on<SignupChangeUsername>(_signupChangeUsernameHandler);
    on<SignupConfirm>(_signupConfirmHandler);
  }

  Future<void> _signupChangeEmailHandler(
    SignupChangeEmail event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(
      status: ECommonStatus.init,
      email: event.email,
    ));
  }

  Future<void> _signupChangePasswordHandler(
    SignupChangePassword event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(
      status: ECommonStatus.init,
      password: event.password,
    ));
  }

  Future<void> _signupChangeUsernameHandler(
    SignupChangeUsername event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(
      status: ECommonStatus.init,
      username: event.username,
    ));
  }

  Future<void> _signupConfirmHandler(
    SignupConfirm event,
    Emitter<SignupState> emit,
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

      var res = await authRepository.postRegistr(
        email: state.email!,
        password: state.password!,
        username: state.username!,
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
