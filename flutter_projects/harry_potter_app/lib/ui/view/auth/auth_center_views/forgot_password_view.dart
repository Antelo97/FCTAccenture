import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter_app/ui/bloc/auth/auth_bloc.dart';
import 'package:harry_potter_app/ui/bloc/auth/auth_event.dart';
import 'package:harry_potter_app/ui/bloc/auth/auth_state.dart';
import 'package:harry_potter_app/ui/view/auth/auth_constants.dart';
import 'package:harry_potter_app/utilities/dialogs/error_dialog.dart';
import 'package:harry_potter_app/utilities/dialogs/password_reset_email_sent_dialog.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _email;

  @override
  void initState() {
    _email = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateOnForgotPassword) {
          if (state.hasSentEmail) {
            _email.clear();
            await showPasswordResentSentDialog(context);
          }
          if (state.exception != null) {
            // ignore: use_build_context_synchronously
            await showErrorDialog(context,
                'We could not process your request. Please make sure you are a registered user, or if not, register a user now going back one step.');
          }
        }
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: Container(
            height: 310,
            decoration: BoxDecoration(
              color: const Color(0xD9FFFFFF).withOpacity(0.9),
              border: Border.all(
                color: Colors.black,
                width: 4,
              ),
              borderRadius: BorderRadius.circular(22),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 0,
                  blurRadius: 14,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
                  child: Text(
                    AuthConstants.msgForgotPassword,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.6,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                  child: TextField(
                    controller: _email,
                    autofocus: true,
                    cursorColor: Colors.black,
                    cursorHeight: 18,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      letterSpacing: 1,
                      fontSize: 12,
                      fontFamily: 'Apple Days',
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(1),
                      contentPadding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
                      hintText: AuthConstants.email,
                      hintStyle: const TextStyle(
                        letterSpacing: 2,
                        color: Colors.black38,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Apple Butter',
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 5,
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: Colors.black,
                        size: 26,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        //searchText = value;
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 130,
                      child: RawMaterialButton(
                        fillColor: Colors.black.withOpacity(0.75),
                        hoverColor: Colors.yellow,
                        highlightColor: Colors.yellow,
                        splashColor: Colors.yellow,
                        padding: const EdgeInsets.fromLTRB(4, 4, 4, 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(
                            color: Colors.blue,
                            width: 1.5,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(4, 4, 4, 0),
                          child: Text(
                            AuthConstants.sendLink,
                            style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 3,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Apple Days",
                            ),
                          ),
                        ),
                        onPressed: () {
                          final email = _email.text;
                          Future.delayed(const Duration(milliseconds: 200))
                              .then(
                            (_) => context
                                .read<AuthBloc>()
                                .add(AuthEventForgotPassword(email: email)),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                  child: GestureDetector(
                    child: const Text(
                      AuthConstants.backToLoginPage,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Apple Butter',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.black,
                        decorationThickness: 4,
                      ),
                    ),
                    onTap: () {
                      context.read<AuthBloc>().add(
                            const AuthEventSignOut(),
                          );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// child: Scaffold(
//           appBar: AppBar(
//             title: const Text('Forgot Password'),
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 const Text(
//                     'If you forgot your password, simply enter your email and we will send you a password reset link.'),
//                 TextField(
//                   keyboardType: TextInputType.emailAddress,
//                   autocorrect: false,
//                   autofocus: true,
//                   controller: _controller,
//                   decoration:
//                       const InputDecoration(hintText: 'Your emai address...'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     final email = _controller.text;
//                     context
//                         .read<AuthBloc>()
//                         .add(AuthEventForgotPassword(email: email));
//                   },
//                   child: const Text('Send me password reset link'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     context.read<AuthBloc>().add(
//                           const AuthEventSignOut(),
//                         );
//                   },
//                   child: const Text('Back to login page'),
//                 ),
//               ],
//             ),
//           )),
