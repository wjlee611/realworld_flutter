import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_world/bloc/signin/signin_event.dart';
import 'package:real_world/bloc/signin/signin_state.dart';
import 'package:real_world/common/enum/common_status_enum.dart';
import 'package:real_world/repository/auth_repository.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final AuthRepository authRepository;

  SigninBloc({
    required this.authRepository,
  }) : super(const SigninState()) {
    on<SigninChangeEmail>(_signinChangeEmailHandler);
    on<SigninChangePassword>(_signinChangePasswordHandler);
    on<SigninConfirm>(_signinConfirmHandler);
  }

  Future<void> _signinChangeEmailHandler(
    SigninChangeEmail event,
    Emitter<SigninState> emit,
  ) async {
    emit(state.copyWith(
      status: ECommonStatus.init,
      email: event.email,
    ));
  }

  Future<void> _signinChangePasswordHandler(
    SigninChangePassword event,
    Emitter<SigninState> emit,
  ) async {
    emit(state.copyWith(
      status: ECommonStatus.init,
      password: event.password,
    ));
  }

  Future<void> _signinConfirmHandler(
    SigninConfirm event,
    Emitter<SigninState> emit,
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

      var res = await authRepository.postLogin(
        email: state.email!,
        password: state.password!,
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
