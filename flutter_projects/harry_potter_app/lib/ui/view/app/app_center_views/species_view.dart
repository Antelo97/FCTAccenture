import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:harry_potter_app/ui/view/app/constants_app_view.dart';

class SpeciesView extends StatefulWidget {
  const SpeciesView({super.key});

  @override
  State<SpeciesView> createState() => _SpeciesViewState();
}

class _SpeciesViewState extends State<SpeciesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: const Text(AppConstants.species),
      ),
    );
  }
}
