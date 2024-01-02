abstract class SignupEvent {}

class SignupChangeEmail extends SignupEvent {
  final String email;

  SignupChangeEmail(this.email);
}

class SignupChangePassword extends SignupEvent {
  final String password;

  SignupChangePassword(this.password);
}

class SignupChangeUsername extends SignupEvent {
  final String username;

  SignupChangeUsername(this.username);
}

class SignupConfirm extends SignupEvent {}
