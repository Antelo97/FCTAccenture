import 'package:flutter/material.dart';
import 'package:harry_potter_app/ui/view/app/constants_app_view.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: const Text(AppConstants.characters),
    );
  }
}
