abstract class SigninEvent {}

class SigninChangeEmail extends SigninEvent {
  final String email;

  SigninChangeEmail(this.email);
}

class SigninChangePassword extends SigninEvent {
  final String password;

  SigninChangePassword(this.password);
}

class SigninConfirmEvent extends SigninEvent {}
