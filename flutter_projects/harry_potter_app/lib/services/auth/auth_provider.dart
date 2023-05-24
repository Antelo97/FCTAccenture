import 'package:harry_potter_app/data/cloud_firebase_db/model_collection/user_collection.dart';

abstract class AuthProvider {
  Future<UserCollection?> get currentUserFromCloudFirestore;
  Future<void> initialize();
  Future<UserCollection> createUser({
    required String email,
    required String password,
  });
  Future<UserCollection> signIn({
    required String email,
    required String password,
  });
  Future<void> signOut();
  Future<void> sendEmailVerification();
  Future<void> sendPasswordReset({required String toEmail});
}
