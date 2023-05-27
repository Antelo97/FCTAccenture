import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;
import 'package:harry_potter_app/domain/model/auth_user.dart';
import 'package:harry_potter_app/domain/repository/auth_user_repository.dart';
import 'package:harry_potter_app/firebase_options.dart';

import 'auth_exceptions.dart';
import 'auth_provider.dart';

class FirebaseAuthProvider implements AuthProvider {
  late AuthUserRepository authUserRepository;

  @override
  Future<AuthUser?> get currentUserFromCloudFirestore async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return await authUserRepository.getUserFromCloudFirebase(user.uid);
    } else {
      return null;
    }
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    authUserRepository = AuthUserRepository();
  }

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      if (user != null) {
        final userCollection = await authUserRepository.insertUser(user);
        return userCollection;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // await Future.delayed(const Duration(seconds: 3));
      final userCredentials =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredentials.user;
      if (user != null) {
        final userCollection =
            await authUserRepository.getUserFromCloudFirebase(user.uid);
        if (user.emailVerified && userCollection == null) {
          return await authUserRepository.insertUser(user);
        } else {
          return AuthUser.fromFirebase(user);
        }
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == 'wrong-password' || e.code == 'too-many-requests') {
        throw WrongPasswordAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> signOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> sendPasswordReset({required String toEmail}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: toEmail);
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'firebase-auth/invalid-email':
          throw InvalidEmailAuthException();
        case 'firebase-auth/user-not-found':
          throw UserNotFoundAuthException();
        default:
          throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }
}
