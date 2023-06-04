import 'package:flutter/material.dart';
import 'package:harry_potter_app/ui/view/auth/auth_constants.dart';

class AuthWidgets {
  static Widget background = Container(
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
  );

  // static Future<dynamic> getForgotPasswordWindow(
  //     BuildContext context, TextEditingController tec, bool bol) {
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text(
  //           AuthConstants.forgotPasswordAlert,
  //           style: TextStyle(
  //             color: Colors.black.withOpacity(0.75),
  //             fontFamily: 'Apple Days',
  //             fontSize: 20,
  //             fontWeight: FontWeight.bold,
  //             letterSpacing: 3,
  //           ),
  //         ),
  //         content: Align(
  //           alignment: Alignment.center,
  //           child: SizedBox(
  //             height: 100,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: [
  //                 TextField(
  //                   controller: tec,
  //                   autofocus: true,
  //                   cursorColor: Colors.black,
  //                   cursorHeight: 18,
  //                   keyboardType: TextInputType.emailAddress,
  //                   style: const TextStyle(
  //                     letterSpacing: 1,
  //                     fontSize: 12,
  //                     fontFamily: 'Apple Days',
  //                     color: Colors.black,
  //                   ),
  //                   decoration: InputDecoration(
  //                     filled: true,
  //                     fillColor: bol
  //                         ? Colors.white.withOpacity(1)
  //                         : Colors.white.withOpacity(0.5),
  //                     contentPadding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
  //                     hintText: AuthConstants.email,
  //                     hintStyle: const TextStyle(
  //                       letterSpacing: 2,
  //                       color: Colors.black38,
  //                       fontSize: 18,
  //                       fontStyle: FontStyle.italic,
  //                       fontFamily: 'Apple Butter',
  //                     ),
  //                     enabledBorder: const UnderlineInputBorder(
  //                       borderSide: BorderSide(
  //                         color: Colors.black,
  //                         width: 2,
  //                       ),
  //                     ),
  //                     focusedBorder: const UnderlineInputBorder(
  //                       borderSide: BorderSide(
  //                         color: Colors.blue,
  //                         width: 5,
  //                       ),
  //                     ),
  //                     prefixIcon: const Icon(
  //                       Icons.email_outlined,
  //                       color: Colors.black,
  //                       size: 26,
  //                     ),
  //                   ),
  //                   onTap: () {},
  //                   onTapOutside: (event) {},
  //                   onChanged: (value) {},
  //                 ),
  //                 RawMaterialButton(
  //                   fillColor: Colors.black.withOpacity(0.75),
  //                   hoverColor: Colors.yellow,
  //                   highlightColor: Colors.yellow,
  //                   splashColor: Colors.yellow,
  //                   padding: const EdgeInsets.fromLTRB(4, 4, 4, 10),
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(8),
  //                     side: const BorderSide(
  //                       color: Colors.blue,
  //                       width: 1.5,
  //                     ),
  //                   ),
  //                   child: const Padding(
  //                     padding: EdgeInsets.fromLTRB(4, 4, 4, 0),
  //                     child: Text(
  //                       AuthConstants.signIn,
  //                       style: TextStyle(
  //                         fontSize: 14,
  //                         letterSpacing: 3,
  //                         color: Colors.white,
  //                         fontWeight: FontWeight.bold,
  //                         fontFamily: "Apple Days",
  //                       ),
  //                     ),
  //                   ),
  //                   onPressed: () {
  //                     // final email = _email.text;
  //                     // final password = _password.text;
  //                     // context.read<AuthBloc>().add(
  //                     //       AuthEventSignIn(
  //                     //         email: email,
  //                     //         password: password,
  //                     //       ),
  //                     //     );
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // static Future<Widget> getForgotPasswordWindow() async {
  //   return Container(
  //     color: Colors.amber,
  //   );
  // }
}
