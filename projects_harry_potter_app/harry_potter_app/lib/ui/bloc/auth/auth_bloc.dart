import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harry_potter_app/domain/model/auth_user.dart';
import 'package:harry_potter_app/domain/repository/species_repository.dart';
import 'package:harry_potter_app/domain/repository/spell_repository.dart';
import 'package:harry_potter_app/domain/repository/book_repository.dart';
import 'package:harry_potter_app/domain/repository/character_repository.dart';
import 'package:harry_potter_app/services/auth/auth_provider.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthProvider authProvider;

  AuthBloc({required this.authProvider})
      : super(const AuthStateZero(isLoading: true)) {
    on<AuthEventInitializeFirebase>(onAuthEventInitializeFirebase);
    on<AuthEventGoToSignUp>(onAuthEventGoToSignUp);
    on<AuthEventSignUp>(onAuthEventSignUp);
    on<AuthEventSendVerificationEmail>(onAuthEventSendVerificationEmail);
    on<AuthEventSignIn>(onAuthEventSignIn);
    on<AuthEventSignOut>(onAuthEventSignOut);
    on<AuthEventForgotPassword>(onAuthEventForgotPassword);
  }

  // Este estado se invoca cada vez que abrimos la aplicación
  void onAuthEventInitializeFirebase(
    AuthEventInitializeFirebase event,
    Emitter<AuthState> emit,
  ) async {
    await authProvider.initialize();

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      emit(
        const AuthStateOnSignIn(
          exception: null,
          isLoading: false,
        ),
      );
    } else if (!user.emailVerified) {
      emit(
        const AuthStateOnVerifyEmail(isLoading: false),
      );
    } else {
      // Sabemos que el usuario nunca va a ser nulo porque al registranos ya lo hemos insertado en Cloud Firestore
      final authUser = await authProvider.currentUserFromCloudFirestore;

      // Cargamos toda la información de la API en Cloud Firestore
      await BookRepository().loadBooksFromApi();
      await CharacterRepository().loadCharactersFromApi();
      await SpellRepository().loadSpellsFromApi();
      await SpeciesRepository().loadSpeciesFromApi();

      // Creamos el Singleton del AuthUser para poder tener acceso global a esa única instancia
      AuthUser.initializeSingleton(authUser!);

      emit(
        AuthStateSignedIn(
          user: authUser,
          isLoading: false,
        ),
      );
    }
  }

  void onAuthEventGoToSignUp(
      AuthEventGoToSignUp event, Emitter<AuthState> emit) {
    emit(
      const AuthStateOnSignUp(
        exception: null,
        isLoading: false,
      ),
    );
  }

  void onAuthEventSignUp(AuthEventSignUp event, Emitter<AuthState> emit) async {
    final username = event.username;
    final email = event.email;
    final password = event.password;

    try {
      await authProvider.createUser(
        username: username,
        email: email,
        password: password,
      );

      await authProvider.sendEmailVerification();

      emit(
        const AuthStateOnVerifyEmail(isLoading: false),
      );
    } on Exception catch (e) {
      emit(
        AuthStateOnSignUp(
          exception: e,
          isLoading: false,
        ),
      );
    }
  }

  void onAuthEventSendVerificationEmail(
      AuthEventSendVerificationEmail event, Emitter<AuthState> emit) async {
    await authProvider.sendEmailVerification();
    emit(state);
  }

  void onAuthEventSignIn(AuthEventSignIn event, Emitter<AuthState> emit) async {
    emit(
      const AuthStateOnSignIn(
        exception: null,
        isLoading: true,
        loadingText: 'Please wait while I log you in',
      ),
    );

    // await Future.delayed(const Duration(seconds: 3));
    final email = event.email;
    final password = event.password;

    try {
      final authUser = await authProvider.signIn(
        email: email,
        password: password,
      );

      if (!authUser.isEmailVerified) {
        emit(
          const AuthStateOnSignIn(
            exception: null,
            isLoading: false,
          ),
        );
        emit(
          const AuthStateOnVerifyEmail(isLoading: false),
        );
      } else {
        // Creamos el Singleton del AuthUser para poder tener acceso global a esa única instancia
        AuthUser.initializeSingleton(authUser);

        emit(
          const AuthStateOnSignIn(
            exception: null,
            isLoading: false,
          ),
        );
        emit(AuthStateSignedIn(
          user: authUser,
          isLoading: false,
        ));
      }
    } on Exception catch (e) {
      emit(
        AuthStateOnSignIn(
          exception: e,
          isLoading: false,
        ),
      );
    }
  }

  void onAuthEventSignOut(
      AuthEventSignOut event, Emitter<AuthState> emit) async {
    try {
      await authProvider.signOut();
      emit(
        const AuthStateOnSignIn(
          exception: null,
          isLoading: false,
        ),
      );
    } on Exception catch (e) {
      emit(
        AuthStateOnSignIn(
          exception: e,
          isLoading: false,
        ),
      );
    }
  }

  void onAuthEventForgotPassword(
      AuthEventForgotPassword event, Emitter<AuthState> emit) async {
    emit(const AuthStateOnForgotPassword(
      exception: null,
      hasSentEmail: false,
      isLoading: false,
    ));
    final email = event.email;
    if (email == null) {
      return; // User just wants to go to forgot password screen
    }

    // User wants to actually send a forgot password email
    emit(const AuthStateOnForgotPassword(
      exception: null,
      hasSentEmail: false,
      isLoading: true,
    ));

    Exception? exception;
    bool didSendEmail;
    try {
      await authProvider.sendPasswordReset(toEmail: email);
      exception = null;
      didSendEmail = true;
    } on Exception catch (e) {
      exception = e;
      didSendEmail = false;
    }

    emit(AuthStateOnForgotPassword(
      exception: exception,
      hasSentEmail: didSendEmail,
      isLoading: false,
    ));

    // switch (event.email.runtimeType) {
    //   case Null:
    //     print('aqui: null');
    //     // El usuario simplemente ha hecho clic para invocar el Dialog del Forgot Password
    //     emit(
    //       const AuthStateOnSignIn(
    //         isForgotPassword: true,
    //         // hasSentEmail: false,
    //       ),
    //     );
    //     break;
    //   case String:
    //     print('aqui: notnull');
    //     // EL usuario ya estaba en el Dialog y ha introducido su email para el envio del correo
    //     emit(
    //       const AuthStateOnSignIn(
    //         // hasSentEmail: false,
    //         isForgotPassword: true,
    //         isLoading: true,
    //       ),
    //     );

    //     Exception? exception;
    //     // bool didSendEmail;
    //     try {
    //       await authProvider.sendPasswordReset(toEmail: event.email!);
    //       exception = null;
    //       // didSendEmail = true;
    //     } on Exception catch (e) {
    //       exception = e;
    //       // didSendEmail = false;
    //     }

    //     emit(AuthStateOnSignIn(
    //       exception: exception,
    //       isForgotPassword: true,
    //       // hasSentEmail: didSendEmail,
    //     ));
    // }
  }
}
