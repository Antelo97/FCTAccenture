import 'package:harry_potter_app/domain/model/auth_user.dart';

abstract class AuthProvider {
  Future<AuthUser?> get currentUserFromCloudFirestore;
  Future<void> initialize();
  Future<AuthUser> createUser({
    required String username,
    required String email,
    required String password,
  });
  Future<AuthUser> signIn({
    required String email,
    required String password,
  });
  Future<void> signOut();
  Future<void> sendEmailVerification();
  Future<void> sendPasswordReset({required String toEmail});
}
