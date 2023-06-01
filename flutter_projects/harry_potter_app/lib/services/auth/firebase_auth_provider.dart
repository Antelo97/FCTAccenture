import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;
import 'package:harry_potter_app/domain/model/auth_user.dart';
import 'package:harry_potter_app/domain/repository/auth_user_repository.dart';
import 'package:harry_potter_app/firebase_options.dart';

import 'auth_exceptions.dart';
import 'auth_provider.dart';

// Decido trabajar con el AuthUserRepository en esta clase para integrar en el AuthProvider el acceso a
// Cloud Firestore, de forma que cuando se cree un usuario en Firestore, este se agregue automáticamente
// en Cloud Firestore sin tener que hacer una doble llamada a nivel de Bloc (una para crear el usuario
// en Firestore con el Provider y otra para insetarlo en Cloud Firestore con el AuthUserRepository)

class FirebaseAuthProvider implements AuthProvider {
  // Tiene que ser late porque el BlocProvider recibe como parámetro el AuthProvider
  // antes de inicializarse Firebase
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
    required String username,
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
        final authUser = AuthUser.fromFirebase(user, username);
        return await authUserRepository.insertUser(authUser);
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
    } catch (e) {
      throw GenericAuthException();
    }
  }

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredentials =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredentials.user;

      if (user != null) {
        final authUser = await currentUserFromCloudFirestore;
        return authUser!;
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
