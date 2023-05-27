import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harry_potter_app/domain/repository/species_repository.dart';
import 'package:harry_potter_app/domain/repository/spell_repository.dart';
import 'package:harry_potter_app/domain/repository/book_repository.dart';
import 'package:harry_potter_app/domain/repository/character_repository.dart';
import 'package:harry_potter_app/domain/repository/auth_user_repository.dart';
import 'package:harry_potter_app/services/auth/auth_provider.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthProvider authProvider;
  late AuthUserRepository userRepository;
  late BookRepository bookRepository;
  late CharacterRepository characterRepository;
  late SpellRepository spellRepository;
  late SpeciesRepository speciesRepository;

  AuthBloc({required this.authProvider})
      : super(const AuthStateUninitialized(isLoading: true)) {
    on<AuthEventInitialize>(onAuthEventInitializeFirebase);
    on<AuthEventShouldRegister>(onAuthEventGoToSignUp);
    on<AuthEventRegister>(onAuthEventSignUp);
    on<AuthEventSendEmailVerification>(onAuthEventSendVerificationEmail);
    on<AuthEventSignIn>(onAuthEventSignIn);
    on<AuthEventSignOut>(onAuthEventSignOut);
    on<AuthEventForgotPassword>(onAuthEventForgotPassword);
  }

  void onAuthEventInitializeFirebase(
    AuthEventInitialize event,
    Emitter<AuthState> emit,
  ) async {
    await authProvider.initialize();

    // Una vez inicializado Firebase, ya podemos instanciar nuestros repositorios
    userRepository = AuthUserRepository();
    bookRepository = BookRepository();
    characterRepository = CharacterRepository();
    spellRepository = SpellRepository();
    speciesRepository = SpeciesRepository();

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(
        const AuthStateLoggedOut(
          exception: null,
          isLoading: false,
        ),
      );
    } else if (!user.emailVerified) {
      emit(const AuthStateNeedsVerification(isLoading: false));
    } else {
      final userLogged = await authProvider.currentUserFromCloudFirestore;
      emit(AuthStateLoggedIn(
        user: userLogged!,
        isLoading: false,
      ));
    }
  }

  void onAuthEventGoToSignUp(
      AuthEventShouldRegister event, Emitter<AuthState> emit) {
    (event, emit) {
      emit(const AuthStateRegistering(
        exception: null,
        isLoading: false,
      ));
    };
  }

  void onAuthEventSignUp(
      AuthEventRegister event, Emitter<AuthState> emit) async {
    final email = event.email;
    final password = event.password;

    try {
      await authProvider.createUser(
        email: email,
        password: password,
      );
      await authProvider.sendEmailVerification();
      emit(const AuthStateNeedsVerification(isLoading: false));
    } on Exception catch (e) {
      emit(AuthStateRegistering(
        exception: e,
        isLoading: false,
      ));
    }
  }

  void onAuthEventSendVerificationEmail(
      AuthEventSendEmailVerification event, Emitter<AuthState> emit) async {
    await authProvider.sendEmailVerification();
    emit(state);
  }

  void onAuthEventSignIn(AuthEventSignIn event, Emitter<AuthState> emit) async {
    emit(
      const AuthStateLoggedOut(
        exception: null,
        isLoading: true,
        loadingText: 'Please wait while I log you in',
      ),
    );
    // await Future.delayed(const Duration(seconds: 3));
    final email = event.email;
    final password = event.password;
    try {
      final user = await authProvider.signIn(
        email: email,
        password: password,
      );

      if (!user.isEmailVerified) {
        emit(
          const AuthStateLoggedOut(
            exception: null,
            isLoading: false,
          ),
        );
        emit(const AuthStateNeedsVerification(isLoading: false));
      } else {
        emit(
          const AuthStateLoggedOut(
            exception: null,
            isLoading: false,
          ),
        );
        emit(AuthStateLoggedIn(
          user: user,
          isLoading: false,
        ));
      }
    } on Exception catch (e) {
      emit(
        AuthStateLoggedOut(
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
        const AuthStateLoggedOut(
          exception: null,
          isLoading: false,
        ),
      );
    } on Exception catch (e) {
      emit(
        AuthStateLoggedOut(
          exception: e,
          isLoading: false,
        ),
      );
    }
  }

  void onAuthEventForgotPassword(
      AuthEventForgotPassword event, Emitter<AuthState> emit) async {
    emit(const AuthStateForgotPassword(
      exception: null,
      hasSentEmail: false,
      isLoading: false,
    ));
    final email = event.email;
    if (email == null) {
      return; // User just wants to go to forgot password screen
    }

    // User wants to actually send a forgot password email
    emit(const AuthStateForgotPassword(
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

    emit(AuthStateForgotPassword(
      exception: exception,
      hasSentEmail: didSendEmail,
      isLoading: false,
    ));
  }
}
