import 'package:harry_potter_app/domain/model/auth_user.dart';

import 'auth_provider.dart';
import 'firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;

  const AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<AuthUser?> get currentUserFromCloudFirestore =>
      provider.currentUserFromCloudFirestore;

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<AuthUser> createUser({
    required String username,
    required String email,
    required String password,
  }) =>
      provider.createUser(
        username: username,
        email: email,
        password: password,
      );

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) =>
      provider.signIn(
        email: email,
        password: password,
      );

  @override
  Future<void> signOut() => provider.signOut();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  Future<void> sendPasswordReset({required String toEmail}) =>
      provider.sendPasswordReset(toEmail: toEmail);
}
