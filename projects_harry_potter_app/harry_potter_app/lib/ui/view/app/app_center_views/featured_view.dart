import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter_app/domain/model/book.dart';
import 'package:harry_potter_app/domain/model/character.dart';
import 'package:harry_potter_app/domain/model/species.dart';
import 'package:harry_potter_app/domain/model/spell.dart';
import 'package:harry_potter_app/ui/bloc/app/app_bloc.dart';
import 'package:harry_potter_app/ui/bloc/app/app_state.dart';
import 'package:harry_potter_app/ui/view/app/app_constants.dart';
import 'package:harry_potter_app/utilities/widgets/auth_widgets.dart';

class FeaturedView extends StatefulWidget {
  final AppStateOnFeaturedView state;

  const FeaturedView({
    super.key,
    required this.state,
  });

  @override
  State<FeaturedView> createState() => _FeaturedViewState();
}

class _FeaturedViewState extends State<FeaturedView> {
  late final Map<Book, int> _featuredBooks;
  late final Map<Character, int> _featuredCharacters;
  late final Map<Spell, int> _featuredSpells;
  late final Map<Species, int> _featuredSpecies;

  @override
  void initState() {
    _featuredBooks = widget.state.featuredBooks;
    _featuredCharacters = widget.state.featuredCharacters;
    _featuredSpells = widget.state.featuredSpells;
    _featuredSpecies = widget.state.featuredSpecies;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        // ToDo
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 6, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // * El Exanded es imprescindible para que no revienten los tamaños
            // * Creo que sirve para visibilizar widdgets sin tamaño predefinido en Columns & Rows
            Expanded(
              child: Row(
                children: [
                  getRotatedText(AppConstants.books),
                  Expanded(
                    child: getFeaturedListView(AppConstants.books),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  getRotatedText(AppConstants.characters),
                  Expanded(
                    child: getFeaturedListView(AppConstants.characters),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  getRotatedText(AppConstants.spells),
                  Expanded(
                    child: getFeaturedListView(AppConstants.spells),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  getRotatedText(AppConstants.species),
                  Expanded(
                    child: getFeaturedListView(AppConstants.species),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getFeaturedListView(String categoryName) {
    Map<dynamic, int> featuredItems = <dynamic, int>{};
    switch (categoryName) {
      case AppConstants.books:
        featuredItems = _featuredBooks;
        break;
      case AppConstants.characters:
        featuredItems = _featuredCharacters;
        break;
      case AppConstants.spells:
        featuredItems = _featuredSpells;
        break;
      case AppConstants.species:
        featuredItems = _featuredSpecies;
    }
    return featuredItems.isNotEmpty
        ? ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: featuredItems.length,
            itemBuilder: (context, index) {
              final item = featuredItems.keys.elementAt(index);
              final counts = featuredItems[item];
              String title = '';

              switch (item.runtimeType) {
                case Book:
                  item as Book;
                  title = item.title;
                  break;
                case Character:
                  item as Character;
                  title = item.name;
                  break;
                case Spell:
                  item as Spell;
                  title = item.name;
                  break;
                case Species:
                  item as Species;
                  title = item.name;
              }

              return GestureDetector(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 0, 0, 16),
                  width: 154,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.amber.withOpacity(0.75),
                      width: 1.5,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: 2,
                        blurRadius: 10,
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
                          fit: BoxFit.cover,
                          placeholder: (context, url) {
                            return Image.network(
                              'https://cdn.dribbble.com/users/4011649/screenshots/10677615/media/948d65ef147246f25e31d44b9a59e660.gif',
                              fit: BoxFit.cover,
                            );
                          },
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        Positioned(
                            top: 6,
                            left: 6,
                            child: Container(
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  border: Border.all(
                                    color: Colors.amber,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                counts.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Apple Butter",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                onDoubleTap: () {
                  AuthWidgets.getItemDialog(
                    context,
                    item,
                  );
                },
              );
            },
          )
        : const Center(
            child: Text(
              AppConstants.noResultsFound,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Apple Days',
                fontSize: 23,
                letterSpacing: 3,
              ),
            ),
          );
  }
}

Widget getRotatedText(String categoryName) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 0, 6, 14),
    child: Container(
      alignment: Alignment.center,
      height: 145,
      width: 30,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
          color: Colors.amber.withOpacity(0.75),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 2,
            blurRadius: 14,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: RotatedBox(
        quarterTurns: 3,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Text(
            !(categoryName == AppConstants.characters)
                ? categoryName
                : 'Charac.',
            style: TextStyle(
              color: Colors.white,
              backgroundColor: Colors.brown.withOpacity(0.35),
              fontFamily: 'Apple Butter',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 8,
            ),
          ),
        ),
      ),
    ),
  );
}
