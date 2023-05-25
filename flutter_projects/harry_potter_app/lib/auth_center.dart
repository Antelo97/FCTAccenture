import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter_app/helpers/loading/loading_screen.dart';
import 'package:harry_potter_app/services/auth/firebase_auth_provider.dart';
import 'package:harry_potter_app/ui/bloc/auth/auth_bloc.dart';
import 'package:harry_potter_app/ui/bloc/auth/auth_event.dart';
import 'package:harry_potter_app/ui/bloc/auth/auth_state.dart';

import 'ui/view/auth/auth_center_views/forgot_password_view.dart';
import 'ui/view/auth/auth_center_views/login_view.dart';
import 'ui/view/auth/auth_center_views/register_view.dart';
import 'ui/view/auth/auth_center_views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  print('Print1');
  // await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(FirebaseAuthProvider()),
      child: const HomePage(),
    ),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print('Print2');
    context.read<AuthBloc>().add(const AuthEventInitialize());
    print('Print3');
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? 'Plase wait a moment',
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          // return const NotesView();
          return Container();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordView();
        } else if (state is AuthStateRegistering) {
          return const RegisterView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
