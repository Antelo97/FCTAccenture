import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter_app/ui/bloc/app/app_bloc.dart';
import 'package:harry_potter_app/ui/bloc/app/app_event.dart';
import 'package:harry_potter_app/ui/bloc/app/app_state.dart';
import 'package:harry_potter_app/ui/view/app/app_center_views/books_view.dart';
import 'package:harry_potter_app/ui/view/app/app_center_views/characters_view.dart';
import 'package:harry_potter_app/ui/view/app/app_center_views/species_view.dart';
import 'package:harry_potter_app/ui/view/app/app_center_views/spells_view.dart';
import 'package:harry_potter_app/ui/view/app/app_center_views/welcome_view.dart';

import 'constants_app_view.dart';

class AppCenter extends StatefulWidget {
  const AppCenter({super.key});

  @override
  State<AppCenter> createState() => _AppCenterState();
}

class _AppCenterState extends State<AppCenter> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('username / correo'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              size: 30,
            ),
            onPressed: () {
              // ToDo
            },
          ),
        ],
      ),
      body: BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {
          // ToDO
        },
        builder: (context, state) {
          if (state is AppStateOnBooksView) {
            return const BooksView();
          } else if (state is AppStateOnCharactersView) {
            return const CharactersView();
          } else if (state is AppStateOnSpellsView) {
            return const SpellsView();
          } else if (state is AppStateOnSpeciesView) {
            return const SpeciesView();
          } else {
            return const WelcomeView();
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) async {
          setState(() {
            _currentIndex = index;
            switch (_currentIndex) {
              case 0:
                context.read<AppBloc>().add(
                      AppEventGoToBooks(),
                    );
                break;
              case 1:
                context.read<AppBloc>().add(
                      AppEventGoToCharacters(),
                    );
                break;
              case 2:
                context.read<AppBloc>().add(
                      AppEventGoToSpells(),
                    );
                break;
              case 3:
                context.read<AppBloc>().add(
                      AppEventGoToSpecies(),
                    );
                break;
            }
          });
        },
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined, size: 30),
            label: AppConstants.books,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined, size: 30),
            label: AppConstants.characters,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thunderstorm_outlined, size: 30),
            label: AppConstants.spells,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forest_outlined, size: 30),
            label: AppConstants.spells,
          ),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: const Color(0xFFD3A625),
        unselectedItemColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: false,
      ),
    );
  }
}
