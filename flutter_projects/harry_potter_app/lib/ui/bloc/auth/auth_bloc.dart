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
  final AuthProvider authProvider;
  late AuthUserRepository authUserRepository;
  late BookRepository bookRepository;
  late CharacterRepository characterRepository;
  late SpellRepository spellRepository;
  late SpeciesRepository speciesRepository;

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

    // Una vez inicializado Firebase, ya podemos instanciar nuestros repositorios
    authUserRepository = AuthUserRepository();
    bookRepository = BookRepository();
    characterRepository = CharacterRepository();
    spellRepository = SpellRepository();
    speciesRepository = SpeciesRepository();

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      emit(
        const AuthStateSignedOut(
          exception: null,
          isLoading: false,
        ),
      );
    } else if (!user.emailVerified) {
      emit(
        const AuthStateNeedsVerification(isLoading: false),
      );
    } else {
      // Sabemos que el usuario nunca va a ser nulo porque al registranos ya lo hemos insertado en Cloud Firestore
      final authUser = await authProvider.currentUserFromCloudFirestore;
      emit(
        AuthStateSignedIn(
          user: authUser!,
          isLoading: false,
        ),
      );
    }
  }

  void onAuthEventGoToSignUp(
      AuthEventGoToSignUp event, Emitter<AuthState> emit) {
    emit(
      const AuthStateSigningUp(
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
        const AuthStateNeedsVerification(isLoading: false),
      );
    } on Exception catch (e) {
      emit(AuthStateSigningUp(
        exception: e,
        isLoading: false,
      ));
    }
  }

  void onAuthEventSendVerificationEmail(
      AuthEventSendVerificationEmail event, Emitter<AuthState> emit) async {
    await authProvider.sendEmailVerification();
    emit(state);
  }

  void onAuthEventSignIn(AuthEventSignIn event, Emitter<AuthState> emit) async {
    emit(
      const AuthStateSignedOut(
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
          const AuthStateSignedOut(
            exception: null,
            isLoading: false,
          ),
        );
        emit(
          const AuthStateNeedsVerification(isLoading: false),
        );
      } else {
        authUser.isEmailVerified = true;
        authUserRepository.updateIsEmailVerified(authUser);
        emit(
          const AuthStateSignedOut(
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
        AuthStateSignedOut(
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
        const AuthStateSignedOut(
          exception: null,
          isLoading: false,
        ),
      );
    } on Exception catch (e) {
      emit(
        AuthStateSignedOut(
          exception: e,
          isLoading: false,
        ),
      );
    }
  }

  void onAuthEventForgotPassword(
      AuthEventForgotPassword event, Emitter<AuthState> emit) async {
    emit(
      const AuthStateForgotPassword(
        exception: null,
        hasSentEmail: false,
        isLoading: false,
      ),
    );

    final email = event.email;
    if (email == null) {
      // El usuario simplemente ha clicado el botón para navegar a la pantalla de ForgotPassword
      return;
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
