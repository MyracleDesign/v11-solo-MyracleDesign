import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const <dynamic>[]]) : super(props);
}

class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged({@required this.email}) : super([email]);

  @override
  String toString() {
    return 'EmailChanged: { email: $email }';
  }
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged({@required this.password}) : super([password]);

  @override
  String toString() {
    return 'PasswordChanged: { password: $password }';
  }
}

class Submitted extends LoginEvent {
  final String email;
  final String password;

  Submitted({@required this.email, @required this.password})
      : super([email, password]);

  @override
  String toString() {
    return 'Submitted: { email: $email, password: $password } ';
  }
}

class LoginWithGooglePressed extends LoginEvent {
  @override
  String toString() {
    return "LoginWithGooglePressed";
  }
}

class LoginWithCredentialsPressed extends LoginEvent {
  final email;
  final password;

  LoginWithCredentialsPressed(
      {@required this.email, @required this.password})
      : super([email, password]);

  @override
  String toString() =>
      "LoginWithCredentialsPressed: { username: $email, password: $password }";
}
