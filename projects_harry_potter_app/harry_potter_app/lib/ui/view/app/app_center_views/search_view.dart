import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter_app/ui/bloc/app/app_bloc.dart';
import 'package:harry_potter_app/ui/bloc/app/app_event.dart';
import 'package:harry_potter_app/ui/view/app/app_constants.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Podemos pasar una función como parámetro o hacer un switch dentro de la función
          getCategoryButton(AppConstants.books, () {
            context.read<AppBloc>().add(
                  AppEventGoToItems(categoryName: AppConstants.books),
                );
          }),
          getCategoryButton(AppConstants.characters, () {
            context.read<AppBloc>().add(
                  AppEventGoToItems(categoryName: AppConstants.characters),
                );
          }),
          getCategoryButton(AppConstants.spells, () {
            context.read<AppBloc>().add(
                  AppEventGoToItems(categoryName: AppConstants.spells),
                );
          }),
          getCategoryButton(AppConstants.species, () {
            context.read<AppBloc>().add(
                  AppEventGoToItems(categoryName: AppConstants.species),
                );
          }),
        ],
      ),
    );
  }

  Widget getCategoryButton(String categoryName, Function function) {
    return SizedBox(
      child: RawMaterialButton(
        fillColor: Colors.black.withOpacity(0.75),
        hoverColor: Colors.yellow,
        highlightColor: Colors.yellow,
        splashColor: Colors.yellow,
        child: Container(
          height: 100,
          width: 330,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.amber.withOpacity(0.75),
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.7),
                spreadRadius: 4,
                blurRadius: 14,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              categoryName,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Apple Butter',
                fontSize: 44,
                fontWeight: FontWeight.bold,
                letterSpacing: 6,
              ),
            ),
          ),
        ),
        onPressed: () {
          function();
        },
      ),
    );
  }
}
