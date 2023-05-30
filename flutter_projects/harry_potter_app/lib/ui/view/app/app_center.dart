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
        title: const Text(
          'Antelo97',
          style: TextStyle(
            fontFamily: 'Apple Butter',
          ),
        ),
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
      drawer: Drawer(
        shape: const Border(right: BorderSide(width: 3)),
        width: 300,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 3),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF6A3A19),
                    Color(0xFFB48A76),
                  ],
                ),
              ),
              child: Row(
                children: [
                  // Image.network(
                  //   cacheHeight: 100,
                  //   cacheWidth: 100,
                  //   "https://cdn.icon-icons.com/icons2/2805/PNG/512/man_avatar_people_glasses_boy_icon_178891.png",
                  // ),
                  const Icon(
                    Icons.account_circle,
                    size: 60,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Antelo97',
                        style: TextStyle(
                          fontFamily: 'Apple Butter',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'oscaran_97@hotmail.com',
                        style: TextStyle(
                          fontFamily: 'Apple Butter',
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // Books
            const SizedBox(
              height: 12,
            ),
            ListTile(
              title: const Text(
                AppConstants.books,
                style: TextStyle(
                  fontFamily: 'Apple Butter',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              splashColor: Colors.amber,
              subtitle: const Text(
                'Go to the book list!',
                style: TextStyle(
                  fontFamily: 'Apple Butter',
                  fontSize: 16,
                  letterSpacing: 1,
                ),
              ),
              leading: const Icon(
                Icons.book_outlined,
                size: 35,
                color: Colors.black87,
              ),
              onTap: () {
                context.read<AppBloc>().add(
                      AppEventGoToBooks(),
                    );
                Navigator.pop(context);
              },
            ),
            // Characters
            getSizedBoxWithDivider(),
            ListTile(
              splashColor: Colors.amber,
              subtitle: const Text(
                'Go to the character list!',
                style: TextStyle(
                  fontFamily: 'Apple Butter',
                  fontSize: 16,
                  letterSpacing: 1,
                ),
              ),
              leading: const Icon(
                Icons.people_alt_outlined,
                size: 35,
                color: Colors.black87,
              ),
              title: const Text(
                AppConstants.characters,
                style: TextStyle(
                  fontFamily: 'Apple Butter',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              onTap: () {
                context.read<AppBloc>().add(
                      AppEventGoToCharacters(),
                    );
                Navigator.pop(context);
              },
            ),
            // Spell
            getSizedBoxWithDivider(),
            ListTile(
              splashColor: Colors.amber,
              subtitle: const Text(
                'Go to the spell list!',
                style: TextStyle(
                  fontFamily: 'Apple Butter',
                  fontSize: 16,
                  letterSpacing: 1,
                ),
              ),
              leading: const Icon(
                Icons.thunderstorm_outlined,
                size: 35,
                color: Colors.black87,
              ),
              title: const Text(
                AppConstants.spells,
                style: TextStyle(
                  fontFamily: 'Apple Butter',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              onTap: () {
                context.read<AppBloc>().add(
                      AppEventGoToSpells(),
                    );
                Navigator.pop(context);
              },
            ),
            // Species
            getSizedBoxWithDivider(),
            ListTile(
              splashColor: Colors.amber,
              subtitle: const Text(
                'Go to the species list!',
                style: TextStyle(
                  fontFamily: 'Apple Butter',
                  fontSize: 16,
                  letterSpacing: 1,
                ),
              ),
              leading: const Icon(
                Icons.forest_outlined,
                size: 35,
                color: Colors.black87,
              ),
              title: const Text(
                AppConstants.species,
                style: TextStyle(
                  fontFamily: 'Apple Butter',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              onTap: () {
                context.read<AppBloc>().add(
                      AppEventGoToSpecies(),
                    );
                Navigator.pop(context);
              },
            ),
          ],
        ),
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
            }
          });
        },
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.star, size: 30),
            label: AppConstants.favorites,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 30),
            label: AppConstants.search,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note, size: 30),
            label: AppConstants.featured,
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

Widget getSizedBoxWithDivider() {
  return const SizedBox(
    height: 12,
    child: Divider(
      color: Colors.black38,
      thickness: 1.5,
      indent: 50,
      endIndent: 50,
    ),
  );
}
