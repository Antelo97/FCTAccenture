import 'package:flutter/foundation.dart' show immutable;
import 'package:harry_potter_app/domain/model/auth_user.dart';

@immutable
abstract class AuthState {
  final bool isLoading;
  final String loadingText;

  const AuthState({
    this.isLoading = false,
    this.loadingText = 'Please wait a moment',
  });
}

class AuthStateZero extends AuthState {
  const AuthStateZero({required bool isLoading}) : super(isLoading: isLoading);
}

class AuthStateOnSignIn extends AuthState /*with EquatableMixin*/ {
  final Exception? exception;

  const AuthStateOnSignIn({
    this.exception,
    super.isLoading,
    super.loadingText,
  });

  @override
  List<Object?> get props => [exception, isLoading];
}

class AuthStateSignedIn extends AuthState {
  final AuthUser user;

  const AuthStateSignedIn({
    required this.user,
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class AuthStateOnVerifyEmail extends AuthState {
  const AuthStateOnVerifyEmail({required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStateOnSignUp extends AuthState {
  final Exception? exception;

  const AuthStateOnSignUp({
    required this.exception,
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class AuthStateOnForgotPassword extends AuthState {
  final Exception? exception;
  final bool hasSentEmail;

  const AuthStateOnForgotPassword({
    required this.exception,
    required this.hasSentEmail,
    required bool isLoading,
  }) : super(isLoading: isLoading);
}
