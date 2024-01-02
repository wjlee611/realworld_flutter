import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_world/bloc/authentication/auth_event.dart';
import 'package:real_world/bloc/authentication/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitState()) {
    on<AuthChange>(_authChangeHandler);
  }

  Future<void> _authChangeHandler(
    AuthChange event,
    Emitter<AuthState> emit,
  ) async {
    emit(event.state);
  }
}
