import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_world/bloc/signin/signin_event.dart';
import 'package:real_world/bloc/signin/signin_state.dart';
import 'package:real_world/common/enum/common_status_enum.dart';
import 'package:real_world/repository/auth_repository.dart';

class SinginBloc extends Bloc<SigninEvent, SigninState> {
  final AuthRepository authRepository;

  SinginBloc({
    required this.authRepository,
  }) : super(const SigninState()) {
    on<SigninChangeEmail>(_signinChangeEmailHandler);
    on<SigninChangePassword>(_signinChangePasswordHandler);
    on<SigninConfirmEvent>(_signinConfirmEventHandler);
  }

  Future<void> _signinChangeEmailHandler(
    SigninChangeEmail event,
    Emitter<SigninState> emit,
  ) async {
    emit(state.copyWith(email: event.email));
  }

  Future<void> _signinChangePasswordHandler(
    SigninChangePassword event,
    Emitter<SigninState> emit,
  ) async {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _signinConfirmEventHandler(
    SigninConfirmEvent event,
    Emitter<SigninState> emit,
  ) async {
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
        user: res,
      ));
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data.toString());
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
