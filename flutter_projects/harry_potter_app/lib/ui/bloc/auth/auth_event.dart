import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventInitializeFirebase extends AuthEvent {
  // Cuando el constructor de la clase padre no recibe argumentos, se puede omitir la llamada a super
  const AuthEventInitializeFirebase() : super();
}

class AuthEventGoToSignUp extends AuthEvent {
  const AuthEventGoToSignUp();
}

class AuthEventSignUp extends AuthEvent {
  final String username;
  final String email;
  final String password;

  const AuthEventSignUp({
    required this.username,
    required this.email,
    required this.password,
  });
}

class AuthEventSendVerificationEmail extends AuthEvent {
  const AuthEventSendVerificationEmail();
}

class AuthEventSignIn extends AuthEvent {
  final String email;
  final String password;

  const AuthEventSignIn({
    required this.email,
    required this.password,
  });
}

class AuthEventSignOut extends AuthEvent {
  const AuthEventSignOut();
}

class AuthEventForgotPassword extends AuthEvent {
  final String? email;
  const AuthEventForgotPassword({required this.email});
}
