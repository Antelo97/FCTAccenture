import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter_app/ui/view/app/app_center.dart';
import 'package:harry_potter_app/utilities/loading/loading_screen.dart';
import 'package:harry_potter_app/ui/bloc/auth/auth_bloc.dart';
import 'package:harry_potter_app/ui/bloc/auth/auth_state.dart';

import 'auth_center_views/forgot_password_view.dart';
import 'auth_center_views/login_view.dart';
import 'auth_center_views/register_view.dart';
import 'auth_center_views/verify_email_view.dart';

class AuthCenter extends StatelessWidget {
  const AuthCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          return LoadingScreen().show(
            context: context,
            text: state.loadingText ?? 'Plase wait a moment',
          );
        } else {
          return LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateSignedIn) {
          return const AppCenter();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateSignedOut) {
          return const LoginView();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordView();
        } else if (state is AuthStateSigningUp) {
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
