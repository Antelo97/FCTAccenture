import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter_app/ui/view/app/app_center.dart';
import 'package:harry_potter_app/ui/view/auth/auth_center_views/forgot_password_view.dart';
import 'package:harry_potter_app/utilities/loading/loading_screen.dart';
import 'package:harry_potter_app/ui/bloc/auth/auth_bloc.dart';
import 'package:harry_potter_app/ui/bloc/auth/auth_state.dart';
import 'package:harry_potter_app/utilities/widgets/auth_widgets.dart';
import 'auth_center_views/sign_in_view.dart';
import 'auth_center_views/sign_up_view.dart';
import 'auth_center_views/verify_email_view.dart';

class AuthCenter extends StatelessWidget {
  const AuthCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Permite que al desplegarse el teclado se mantengan fijos los Widgets
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Como el fondo va a ser el mismo en todas las views, lo definimos a este nivel
          // * El resto de auth views lo adoptaran porque no reconstruyen de nuevo el
          // Scaffold y toman el body definido en esta clase.
          // * Para AppCenter aplicaremos la misma estrategia
          AuthWidgets.background,
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.isLoading) {
                return LoadingScreen().show(
                  context: context,
                  text: state.loadingText,
                );
              } else {
                return LoadingScreen().hide();
              }
            },
            builder: (context, state) {
              if (state is AuthStateSignedIn) {
                return AppCenter(authUser: state.user);
              } else if (state is AuthStateOnVerifyEmail) {
                return const VerifyEmailView();
              } else if (state is AuthStateOnSignIn) {
                return const SignInView();
              } else if (state is AuthStateOnForgotPassword) {
                return const ForgotPasswordView();
              } else if (state is AuthStateOnSignUp) {
                return const SignUpView();
              } else {
                return const Scaffold(
                  body: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
