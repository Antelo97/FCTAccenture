import 'package:flutter/material.dart';
import 'package:harry_potter_app/ui/view/app/app_constants.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(35, 75, 35, 0),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/main_image.webp"),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 100),
            child: Text(
              AppConstants.letsStart,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Apple Days',
                fontSize: 26,
                letterSpacing: 4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
