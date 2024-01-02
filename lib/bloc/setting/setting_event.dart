abstract class SettingEvent {}

class SettingChangeUsername extends SettingEvent {
  final String username;

  SettingChangeUsername(this.username);
}

class SettingChangeEmail extends SettingEvent {
  final String email;

  SettingChangeEmail(this.email);
}

class SettingChangePassword extends SettingEvent {
  final String password;

  SettingChangePassword(this.password);
}

class SettingChangeBio extends SettingEvent {
  final String bio;

  SettingChangeBio(this.bio);
}

class SettingConfirm extends SettingEvent {}
