import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter_app/ui/bloc/auth/auth_bloc.dart';
import 'package:harry_potter_app/ui/bloc/auth/auth_event.dart';
import 'package:harry_potter_app/ui/view/auth/auth_constants.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: Container(
          height: 300,
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
                  AuthConstants.firstMsgEmailVerification,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.6,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
                child: Text(
                  AuthConstants.secondMsgEmailVerification,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.6,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
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
                        Future.delayed(const Duration(milliseconds: 200)).then(
                          (_) => context.read<AuthBloc>().add(
                                const AuthEventSendVerificationEmail(),
                              ),
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
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Verify email'),
    //   ),
    //   body: Column(
    //     children: [
    //       const Text(
    //           "We've sent you an email verification. Please open it to verify your account"),
    //       const Text(
    //           "If you haven't received a verification email yet, press the button below"),
    //       TextButton(
    //         onPressed: () {
    //           context.read<AuthBloc>().add(
    //                 const AuthEventSendVerificationEmail(),
    //               );
    //         },
    //         child: const Text('Send email verification'),
    //       ),
    //       TextButton(
    //         onPressed: () async {
    //           context.read<AuthBloc>().add(
    //                 const AuthEventSignOut(),
    //               );
    //         },
    //         child: const Text('Restart'),
    //       )
    //     ],
    //   ),
    // );
  }
}
