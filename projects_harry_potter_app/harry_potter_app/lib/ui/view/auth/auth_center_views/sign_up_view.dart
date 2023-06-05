import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter_app/services/auth/auth_exceptions.dart';
import 'package:harry_potter_app/ui/bloc/auth/auth_bloc.dart';
import 'package:harry_potter_app/ui/bloc/auth/auth_event.dart';
import 'package:harry_potter_app/ui/bloc/auth/auth_state.dart';
import 'package:harry_potter_app/ui/view/auth/auth_constants.dart';
import 'package:harry_potter_app/utilities/dialogs/error_dialog.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late final TextEditingController _username;
  late final TextEditingController _email;
  late final TextEditingController _password;

  bool _isFocusUsername = true;
  bool _isFocusEmail = false;
  bool _isFocusPwd = false;
  bool _isObscurePwd = true;

  @override
  void initState() {
    _username = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateOnSignUp) {
          if (state.exception is WeakPasswordAuthException) {
            await showErrorDialog(context, 'Weak password');
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(context, 'Email is already in use');
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context, 'Invalid email');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Failed to register');
          }
        }
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Container(
            height: 365,
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
                    controller: _username,
                    autofocus: true,
                    cursorColor: Colors.black,
                    cursorHeight: 18,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Apple Butter',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: _isFocusUsername
                          ? Colors.white.withOpacity(1)
                          : Colors.white.withOpacity(0.5),
                      contentPadding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
                      hintText: AuthConstants.username,
                      hintStyle: const TextStyle(
                        letterSpacing: 2,
                        color: Colors.black38,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Apple Butter',
                        fontWeight: FontWeight.bold,
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
                        Icons.account_circle_outlined,
                        color: Colors.black,
                        size: 26,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _isFocusUsername = true;
                        _isFocusEmail = false;
                        _isFocusPwd = false;
                      });
                    },
                    onTapOutside: (event) {
                      setState(() {
                        _isFocusUsername = false;
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
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                  child: TextField(
                    controller: _email,
                    autofocus: true,
                    cursorColor: Colors.black,
                    cursorHeight: 18,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Apple Butter',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: _isFocusEmail
                          ? Colors.white.withOpacity(1)
                          : Colors.white.withOpacity(0.5),
                      contentPadding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
                      hintText: AuthConstants.email,
                      hintStyle: const TextStyle(
                        letterSpacing: 2,
                        color: Colors.black38,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Apple Butter',
                        fontWeight: FontWeight.bold,
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
                        _isFocusUsername = false;
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
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                  child: TextField(
                    controller: _password,
                    autofocus: true,
                    cursorColor: Colors.black,
                    cursorHeight: 18,
                    obscureText: _isObscurePwd,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Apple Butter',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: _isFocusPwd
                          ? Colors.white.withOpacity(1)
                          : Colors.white.withOpacity(0.5),
                      contentPadding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
                      hintText: AuthConstants.password,
                      hintStyle: const TextStyle(
                        letterSpacing: 2,
                        color: Colors.black38,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Apple Butter',
                        fontWeight: FontWeight.bold,
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
                        _isFocusUsername = false;
                        _isFocusEmail = false;
                        _isFocusPwd = true;
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
                      final username = _username.text;
                      final email = _email.text;
                      final password = _password.text;
                      context.read<AuthBloc>().add(
                            AuthEventSignUp(
                              username: username,
                              email: email,
                              password: password,
                            ),
                          );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                  child: GestureDetector(
                    child: const Text(
                      AuthConstants.alreadyRegister,
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
                      context.read<AuthBloc>().add(const AuthEventSignOut());
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
          //   appBar: AppBar(
          //     title: const Text('Register'),
          //   ),
          //   body: Padding(
          //     padding: const EdgeInsets.all(16.0),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         const Text('Enter your email and password to see your notes!'),
          //         TextField(
          //           controller: _username,
          //           enableSuggestions: false,
          //           autocorrect: false,
          //           autofocus: true,
          //           decoration:
          //               const InputDecoration(hintText: 'Enter your username here'),
          //         ),
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
          //         Center(
          //           child: Column(
          //             children: [
          //               TextButton(
          //                 onPressed: () async {
          //                   final username = _username.text;
          //                   final email = _email.text;
          //                   final password = _password.text;
          //                   context.read<AuthBloc>().add(
          //                         AuthEventSignUp(
          //                           username: username,
          //                           email: email,
          //                           password: password,
          //                         ),
          //                       );
          //                 },
          //                 child: const Text('Register'),
          //               ),
          //               TextButton(
          //                 onPressed: () {
          //                   context.read<AuthBloc>().add(const AuthEventSignOut());
          //                 },
          //                 child: const Text('Already register? Login here!'),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
