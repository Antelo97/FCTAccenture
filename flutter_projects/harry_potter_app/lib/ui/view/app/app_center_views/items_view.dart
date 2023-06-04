import 'dart:async';

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

typedef SimplyFunction = Function();

class ItemsView extends StatefulWidget {
  final AppStateOnItemsView state;
  const ItemsView({
    required this.state,
    super.key,
  });

  @override
  State<ItemsView> createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> {
  // Importante definirla aquí y no en la función del ListView para que cada vez que
  // actualicemos su valor se pueda reconstruir la clase acorde a dicho cambio
  bool isExpanded = false;

  late final TextEditingController _searchController;
  final double _radius = 8.0;
  List<dynamic> _listOfItems = [];
  String _hintTextSearch = '';
  Icon _iconSearch = const Icon(Icons.abc);
  late List<bool> _isExpandedList;
  int _count = 0;
  //late int _totalResults = _listOfItems.length;

  final StreamController _streamController = StreamController<List<dynamic>>();
  final ScrollController _scrollController = ScrollController();
  late final Stream<AuthUser> _streamAuthUserForFavs;

  @override
  void initState() {
    // _streamController.add(_listOfItems);
    _hintTextSearch = widget.state.hintTextSearch;
    _iconSearch = widget.state.iconSearch;
    _listOfItems = widget.state.listOfItems;
    _searchController = TextEditingController();
    _streamAuthUserForFavs = widget.state.streamAuthUser;
    _isExpandedList = List.generate(_listOfItems.length, (index) => false);
    _count = widget.state.listOfItems.length;
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        _searchController.clear();
        if (state is AppStateOnItemsView) {
          _count = state.listOfItems.length;
          _hintTextSearch = state.hintTextSearch;
          _iconSearch = state.iconSearch;
          _listOfItems = state.listOfItems;
          //_totalResults = state.listOfItems.length;
        }
      },
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    textAlign: TextAlign.start,
                    cursorColor: Colors.black,
                    style: const TextStyle(
                      letterSpacing: 1,
                      fontSize: 12,
                      fontFamily: 'Apple Days',
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(14, 14, 0, 14),
                      prefixIcon: _iconSearch,
                      suffixIcon: Column(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.search,
                              size: 26,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              context.read<AppBloc>().add(AppEventPressSearch(
                                  categoryName: widget.state.appBarTitle,
                                  inputText: _searchController.text));
                            },
                          ),
                        ],
                      ),
                      hintText: _hintTextSearch,
                      hintStyle: const TextStyle(
                        letterSpacing: 1,
                        color: Colors.black38,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Apple Butter',
                      ),
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(_radius),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      setState(() {
                        //searchText = value;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getRawMattBtn(AppConstants.all, () {
                      context.read<AppBloc>().add(AppEventPressAll(
                          categoryName: widget.state.appBarTitle));
                    }),
                    getRawMattBtn(AppConstants.rndm, () {
                      context.read<AppBloc>().add(AppEventPressRndm(
                          categoryName: widget.state.appBarTitle));
                    }),
                    getRawMattBtn(AppConstants.az, () {
                      context.read<AppBloc>().add(AppEventPressAtoZ(
                          categoryName: widget.state.appBarTitle,
                          listOfItems: _listOfItems));
                    }),
                    getRawMattBtn(AppConstants.za, () {
                      context.read<AppBloc>().add(AppEventPressZtoA(
                          categoryName: widget.state.appBarTitle,
                          listOfItems: _listOfItems));
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: getListView(_listOfItems),
              ),
              const SizedBox(height: 16),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 26, 6),
                  child: (_listOfItems.length >= 2)
                      ? FloatingActionButton(
                          onPressed: () {
                            _scrollController.animateTo(
                              0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                          backgroundColor: Colors.black.withOpacity(0.20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(200),
                          ),
                          child: const Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                          ),
                        )
                      : null,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 6, 26, 0),
                  child: (_listOfItems.length >= 2)
                      ? FloatingActionButton(
                          onPressed: () {
                            _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                          backgroundColor: Colors.black.withOpacity(0.20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(200),
                          ),
                          child: const Icon(
                            Icons.arrow_downward,
                            color: Colors.white,
                          ),
                        )
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getListView(List<dynamic> listOfItems) {
    print('Tamaño $_count');
    return listOfItems.isNotEmpty
        ? ListView.builder(
            controller: _scrollController,
            itemCount: _count,
            itemBuilder: (context, index) {
              print(_count);
              final item = listOfItems.elementAt(index);
              String title = '';
              String details = '';
              TextAlign txtAlignDetails = TextAlign.start;
              double? width;
              double? height;
              BoxFit fit = BoxFit.fill;

              if (item is Book) {
                title = item.title;
                details =
                    '● Author: ${item.author} \n\n● Release date: ${item.releaseDate.substring(0, 10)}';
                txtAlignDetails = TextAlign.start;
                width = 1000;
                height = 500;
                fit = BoxFit.fill;
              } else if (item is Character) {
                title = item.name;
                details =
                    '● Species: ${item.species}\n\n● Gender: ${item.gender}\n\n● House: ${item.house}\n\n● Year of birth: ${item.yearOfBirth}\n\n● Is wizard?:${item.isWizard}\n\n● Ancestry: ${item.ancestry}\n\n● Patronus: ${item.patronus}\n\n● Actor: ${item.actor}\n\n● Wand: ${item.actor}\n\n  ● Wood: ${item.wand.wood}\n\n  ● Core: ${item.wand.core}\n\n  ● Length: ${item.wand.length}';
                txtAlignDetails = TextAlign.start;
                width = 1000;
                height = 380;
                fit = BoxFit.cover;
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

              return Container(
                margin: const EdgeInsets.fromLTRB(16, 10, 16, 20),
                width: width,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_radius),
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
                  borderRadius: BorderRadius.circular(_radius),
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
                          leading: Padding(
                            padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                            child: IconButton(
                              icon: StreamBuilder<AuthUser>(
                                  stream: _streamAuthUserForFavs,
                                  builder: (context, snapshot) {
                                    final bool isFav;
                                    switch (widget.state.appBarTitle) {
                                      case AppConstants.books:
                                        if (snapshot.hasData) {
                                          final books =
                                              snapshot.data!.favoriteBooks;
                                          if (books.contains(item)) {
                                            isFav = true;
                                          } else {
                                            isFav = false;
                                          }
                                        } else {
                                          isFav = false;
                                        }
                                        break;
                                      case AppConstants.characters:
                                        if (snapshot.hasData) {
                                          final characters =
                                              snapshot.data!.favoriteCharacters;
                                          if (characters.contains(item)) {
                                            isFav = true;
                                          } else {
                                            isFav = false;
                                          }
                                        } else {
                                          isFav = false;
                                        }
                                        break;
                                      case AppConstants.spells:
                                        if (snapshot.hasData) {
                                          final spells =
                                              snapshot.data!.favoriteSpells;
                                          if (spells.contains(item)) {
                                            isFav = true;
                                          } else {
                                            isFav = false;
                                          }
                                        } else {
                                          isFav = false;
                                        }
                                        break;
                                      case AppConstants.species:
                                        if (snapshot.hasData) {
                                          final species =
                                              snapshot.data!.favoriteSpecies;
                                          if (species.contains(item)) {
                                            isFav = true;
                                          } else {
                                            isFav = false;
                                          }
                                        } else {
                                          isFav = false;
                                        }
                                        break;
                                      default:
                                        isFav = false;
                                    }
                                    return ShaderMask(
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
                                      child: Icon(
                                        isFav ? Icons.star : Icons.star_border,
                                        size: 34,
                                        shadows: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.75),
                                            spreadRadius: 2,
                                            blurRadius: 8,
                                            offset: const Offset(0, 0),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                              onPressed: () async {
                                context.read<AppBloc>().add(
                                    AppEventAddOrRemoveFavItem(item: item));
                              },
                            ),
                          ),
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
                          subtitle: !_isExpandedList[index]
                              ? const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                  child: Text('(tap to details)',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        letterSpacing: 2,
                                        fontSize: 8,
                                        fontFamily: 'Apple Days',
                                        color: Colors.black,
                                      )),
                                )
                              : null,
                          onExpansionChanged: (value) {
                            setState(() {
                              _isExpandedList[index] = value;
                            });
                          },
                          children: [
                            Text(
                              details,
                              textAlign: txtAlignDetails,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                letterSpacing: 2,
                                fontSize: 10,
                                fontFamily: 'Apple Days',
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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

  Widget getRawMattBtn(String txt, SimplyFunction onPressed) {
    return SizedBox(
      height: 30,
      width: 80,
      child: RawMaterialButton(
        fillColor: Colors.white,
        hoverColor: Colors.yellow,
        highlightColor: Colors.yellow,
        splashColor: Colors.yellow,
        padding: const EdgeInsets.fromLTRB(4, 4, 4, 11),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radius),
          side: const BorderSide(
            color: Colors.black,
            width: 3,
          ),
        ),
        child: Text(
          txt,
          style: const TextStyle(
            fontSize: 16,
            letterSpacing: 2,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: "Apple Butter",
          ),
        ),
        onPressed: () {
          setState(() {
            onPressed();
          });
        },
      ),
    );
  }
}

// Ejemplo para superponer en pantalla cuando ocurra cualquier cosa (en el listener del Bloc)

// if (_totalResults > 100) {
//             print('4022');
//             final state = Overlay.of(context);
//             final renderBox = context.findRenderObject() as RenderBox;
//             final size = renderBox.size;
//             final overlay = OverlayEntry(
//               builder: (context) {
//                 return Material(
//                   child: Container(
//                     width: 100,
//                     height: 100,
//                     color: Colors.red,
//                   ),
//                 );
//               },
//             );
//             state.insert(overlay);
//           }