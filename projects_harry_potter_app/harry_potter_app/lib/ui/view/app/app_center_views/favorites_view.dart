import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter_app/domain/model/auth_user.dart';
import 'package:harry_potter_app/domain/model/book.dart';
import 'package:harry_potter_app/domain/model/character.dart';
import 'package:harry_potter_app/domain/model/species.dart';
import 'package:harry_potter_app/domain/model/spell.dart';
import 'package:harry_potter_app/ui/bloc/app/app_bloc.dart';
import 'package:harry_potter_app/ui/bloc/app/app_event.dart';
import 'package:harry_potter_app/ui/bloc/app/app_state.dart';
import 'package:harry_potter_app/ui/view/app/app_constants.dart';
import 'package:harry_potter_app/utilities/widgets/auth_widgets.dart';

class FavoritesView extends StatefulWidget {
  final AppStateOnFavoritesView state;

  const FavoritesView({
    super.key,
    required this.state,
  });

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  // Variables
  late final Stream<AuthUser> _streamAuthUserForFavs;

  @override
  void initState() {
    _streamAuthUserForFavs = widget.state.streamAuthUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        // ToDO
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
                    child: getFavListView(AppConstants.books),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  getRotatedText(AppConstants.characters),
                  Expanded(
                    child: getFavListView(AppConstants.characters),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  getRotatedText(AppConstants.spells),
                  Expanded(
                    child: getFavListView(AppConstants.spells),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  getRotatedText(AppConstants.species),
                  Expanded(
                    child: getFavListView(AppConstants.species),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getFavListView(String categoryName) {
    return StreamBuilder(
      stream: _streamAuthUserForFavs,
      builder: (context, snapshot) {
        List<dynamic> items = [];
        if (snapshot.hasData) {
          switch (categoryName) {
            case AppConstants.books:
              items = snapshot.data!.favoriteBooks;
              break;
            case AppConstants.characters:
              items = snapshot.data!.favoriteCharacters;
              break;
            case AppConstants.spells:
              items = snapshot.data!.favoriteSpells;
              break;
            case AppConstants.species:
              items = snapshot.data!.favoriteSpecies;
          }
        }
        return items.isNotEmpty
            ? ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items.elementAt(index);
                  String title = '';

                  // Podría plantearlo como en items_view con ifs --> (if item is Book) etc...
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
                              top: -5,
                              left: -5,
                              child: IconButton(
                                icon: ShaderMask(
                                  blendMode: BlendMode.srcATop,
                                  shaderCallback: (bounds) {
                                    return const LinearGradient(
                                      colors: [
                                        Colors.amber,
                                        Colors.amber,
                                        Colors.yellow,
                                        Colors.amber,
                                        Colors.amber,
                                      ],
                                      tileMode: TileMode.mirror,
                                    ).createShader(bounds);
                                  },
                                  child: const Icon(
                                    Icons.cancel,
                                    size: 30,
                                  ),
                                ),
                                onPressed: () async {
                                  context.read<AppBloc>().add(
                                      AppEventAddOrRemoveFavItem(item: item));

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    AuthWidgets.getSnackBar(
                                        AppConstants.removeFromFavs),
                                  );
                                },
                              ),
                            ),
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
            : Center(
                child: Text(
                  AppConstants.noFavsFound,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontFamily: 'Apple Days',
                    fontSize: 20,
                    letterSpacing: 4,
                  ),
                ),
              );
      },
    );
  }

  Widget getRotatedText(String categoryName) {
    return StreamBuilder<AuthUser>(
        stream: _streamAuthUserForFavs,
        builder: (context, snapshot) {
          List<dynamic> items = [];
          if (snapshot.hasData) {
            switch (categoryName) {
              case AppConstants.books:
                items = snapshot.data!.favoriteBooks;
                break;
              case AppConstants.characters:
                items = snapshot.data!.favoriteCharacters;
                break;
              case AppConstants.spells:
                items = snapshot.data!.favoriteSpells;
                break;
              case AppConstants.species:
                items = snapshot.data!.favoriteSpecies;
            }
          }
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 6, 14),
            child: Container(
              alignment: Alignment.center,
              height: 150,
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
                        ? '$categoryName (${items.length})'
                        : 'Charac. (${items.length})',
                    style: TextStyle(
                      color: Colors.white,
                      backgroundColor: Colors.brown.withOpacity(0.35),
                      fontFamily: 'Apple Butter',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
