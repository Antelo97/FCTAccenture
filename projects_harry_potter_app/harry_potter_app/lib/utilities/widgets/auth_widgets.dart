import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:harry_potter_app/domain/model/book.dart';
import 'package:harry_potter_app/domain/model/character.dart';
import 'package:harry_potter_app/domain/model/species.dart';
import 'package:harry_potter_app/domain/model/spell.dart';
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
  static void getItemDialog(BuildContext context, dynamic item) {
    showDialog(
      context: context,
      builder: (context) {
        String title = '';
        String details = '';
        TextAlign txtAlignDetails = TextAlign.start;
        double? width;
        double? height;
        BoxFit fit = BoxFit.fill;
        FontStyle fontStyle = FontStyle.italic;

        if (item is Book) {
          title = item.title;
          details =
              '● Author: ${item.author} \n\n● Release date: ${item.releaseDate.substring(0, 10)}';
          txtAlignDetails = TextAlign.start;
          width = 1000;
          height = 500;
          fit = BoxFit.fill;
          fontStyle = FontStyle.normal;
        } else if (item is Character) {
          title = item.name;
          details =
              '● Species: ${item.species}\n\n● Gender: ${item.gender}\n\n● House: ${item.house}\n\n● Year of birth: ${item.yearOfBirth}\n\n● Is wizard?: ${item.isWizard}\n\n● Ancestry: ${item.ancestry}\n\n● Patronus: ${item.patronus}\n\n● Actor: ${item.actor}\n\n● Wand: ${item.actor}\n\n  - Wood: ${item.wand.wood}\n\n  - Core: ${item.wand.core}\n\n  - Length: ${item.wand.length}';
          txtAlignDetails = TextAlign.start;
          width = 1000;
          height = 380;
          fit = BoxFit.cover;
          fontStyle = FontStyle.normal;
        } else if (item is Spell) {
          title = item.name;
          details = item.description;
          txtAlignDetails = TextAlign.center;
          width = 1000;
          height = 250;
          fit = BoxFit.cover;
        } else if (item is Species) {
          title = item.name;
          details = item.native ?? '';
          txtAlignDetails = TextAlign.center;
          width = 1000;
          height = 350;
          fit = BoxFit.cover;
        }
        // Con los showDialog parece necesario el Material
        return FractionallySizedBox(
          heightFactor: 0.65,
          widthFactor: 1.1,
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: 3,
                    blurRadius: 14,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: item.imageUrl,
                      fit: fit,
                      placeholder: (context, url) {
                        return Image.network(
                          'https://cdn.dribbble.com/users/4011649/screenshots/10677615/media/948d65ef147246f25e31d44b9a59e660.gif',
                          fit: BoxFit.cover,
                        );
                      },
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ExpansionTile(
                        initiallyExpanded: false,
                        tilePadding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                        childrenPadding:
                            const EdgeInsets.fromLTRB(12, 0, 12, 16),
                        iconColor: Colors.black,
                        collapsedIconColor: Colors.black,
                        backgroundColor: Colors.brown,
                        collapsedBackgroundColor:
                            Colors.brown.withOpacity(0.85),
                        title: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            letterSpacing: 2,
                            fontSize: 14,
                            fontFamily: 'Apple Days',
                            color: Colors.black,
                          ),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              details,
                              textAlign: txtAlignDetails,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Apple Butter',
                                fontSize: 16,
                                fontStyle: fontStyle,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static SnackBar getSnackBar(String txt) {
    // final scaffoldMessenger = ScaffoldMessenger.of(context);

    return SnackBar(
      backgroundColor: Colors.amber,
      duration: const Duration(milliseconds: 1500),
      padding: const EdgeInsets.fromLTRB(10, 6, 4, 0),
      closeIconColor: Colors.black,
      showCloseIcon: true,
      shape: const Border(
          top: BorderSide(
        color: Colors.brown,
        width: 2,
      )),
      // action: SnackBarAction(
      //   label: 'Cancel',
      //   onPressed: () {
      //     scaffoldMessenger.hideCurrentSnackBar();
      //   },
      // ),
      content: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(txt,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: "Apple Butter",
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            )),
      ),
    );
  }
}
