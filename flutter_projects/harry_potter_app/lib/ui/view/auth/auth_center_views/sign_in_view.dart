import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter_app/services/auth/auth_exceptions.dart';
import 'package:harry_potter_app/ui/bloc/auth/auth_bloc.dart';
import 'package:harry_potter_app/ui/bloc/auth/auth_state.dart';
import 'package:harry_potter_app/ui/view/auth/auth_constants.dart';
import 'package:harry_potter_app/utilities/dialogs/error_dialog.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool _isObscurePwd = true;
  bool _isFocusEmail = true;
  bool _isFocusPwd = false;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthStateOnSignIn) {
            if (state.exception is UserNotFoundAuthException) {
              await showErrorDialog(
                context,
                'Cannot find a user with the entered credentials',
              );
            } else if (state.exception is WrongPasswordAuthException) {
              await showErrorDialog(context, 'Wrong credentials');
            } else if (state.exception is GenericAuthException) {
              await showErrorDialog(context, 'Authentication error');
            }
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF6A3A19),
                    Color(0xFFB48A76),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 350, 40, 240),
                child: Container(
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                        child: TextField(
                          controller: _email,
                          autofocus: true,
                          cursorColor: Colors.black,
                          cursorHeight: 18,
                          style: const TextStyle(
                            letterSpacing: 1,
                            fontSize: 12,
                            fontFamily: 'Apple Days',
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: _isFocusEmail
                                ? Colors.white.withOpacity(1)
                                : Colors.white.withOpacity(0.5),
                            contentPadding:
                                const EdgeInsets.fromLTRB(0, 14, 0, 0),
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
                          onTap: () {
                            setState(() {
                              _isFocusEmail = true;
                              _isFocusPwd = false;
                            });
                          },
                          onTapOutside: (event) {
                            setState(() {
                              _isFocusEmail = false;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              //searchText = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: TextField(
                          controller: _password,
                          autofocus: false,
                          cursorColor: Colors.black,
                          cursorHeight: 18,
                          obscureText: _isObscurePwd,
                          style: const TextStyle(
                            letterSpacing: 1,
                            fontSize: 12,
                            fontFamily: 'Apple Days',
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.75),
                            contentPadding:
                                const EdgeInsets.fromLTRB(0, 14, 0, 0),
                            hintText: AuthConstants.password,
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
                                width: 4,
                              ),
                            ),
                            prefixIcon: const Icon(
                              Icons.lock_outlined,
                              color: Colors.black,
                              size: 26,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscurePwd
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.black,
                                size: 26,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscurePwd = !_isObscurePwd;
                                });
                              },
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _isFocusPwd = true;
                              _isFocusEmail = false;
                            });
                          },
                          onTapOutside: (event) {
                            setState(() {
                              _isFocusPwd = false;
                            });
                          },
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
                            width: 100,
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
                                  AuthConstants.signIn,
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
                                setState(() {
                                  //onPressed();
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: 100,
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
                                  AuthConstants.signUp,
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
                                setState(() {
                                  //onPressed();
                                });
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 270,
              child: Text(
                AuthConstants.harryPotterApp,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.75),
                  fontFamily: 'Apple Days',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
            ),
          ],
        )

        // child: Scaffold(
        //   body: Padding(
        //     padding: const EdgeInsets.all(16.0),
        //     child: Column(
        //       children: [
        //         const Text(
        //             'Please log in to your accout in order to interact with and create notes!'),
        //         TextField(
        //           controller: _email,
        //           enableSuggestions: false,
        //           autocorrect: false,
        //           keyboardType: TextInputType.emailAddress,
        //           decoration:
        //               const InputDecoration(hintText: 'Enter your email here'),
        //         ),
        //         TextField(
        //           controller: _password,
        //           obscureText: true,
        //           enableSuggestions: false,
        //           autocorrect: false,
        //           decoration:
        //               const InputDecoration(hintText: 'Enter your password here'),
        //         ),
        //         TextButton(
        //           onPressed: () async {
        //             final email = _email.text;
        //             final password = _password.text;
        //             context.read<AuthBloc>().add(
        //                   AuthEventSignIn(
        //                     email: email,
        //                     password: password,
        //                   ),
        //                 );
        //           },
        //           child: const Text('Login'),
        //         ),
        //         TextButton(
        //           onPressed: () {
        //             final email = _email.text;
        //             context.read<AuthBloc>().add(
        //                   AuthEventForgotPassword(email: email),
        //                 );
        //           },
        //           child: const Text('I forgot my password'),
        //         ),
        //         TextButton(
        //           onPressed: () {
        //             context.read<AuthBloc>().add(
        //                   const AuthEventGoToSignUp(),
        //                 );
        //           },
        //           child: const Text('Not registered yet? Register here!'),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}
