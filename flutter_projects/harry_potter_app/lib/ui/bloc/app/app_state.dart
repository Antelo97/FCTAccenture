import 'package:flutter/material.dart';
import 'package:harry_potter_app/domain/model/auth_user.dart';
import 'package:harry_potter_app/domain/repository/auth_user_repository.dart';
import 'package:harry_potter_app/ui/view/app/app_constants.dart';

abstract class AppState {
  final String appBarTitle;
  final Stream<AuthUser> streamAuthUser =
      AuthUserRepository().getStreamUserFromCloudFirebase();

  AppState({required this.appBarTitle});
}

// Estado inerte para inicializar al AppBloc
class AppStateZero extends AppState {
  AppStateZero({required super.appBarTitle});
}

abstract class AppStateOnItemsView extends AppState {
  final String hintTextSearch;
  final Icon iconSearch;
  final List<dynamic> listOfItems;

  AppStateOnItemsView({
    required super.appBarTitle,
    required this.hintTextSearch,
    required this.iconSearch,
    required this.listOfItems,
  });
}

class AppStateOnItemsViewBooks extends AppStateOnItemsView {
  AppStateOnItemsViewBooks({required super.listOfItems})
      : super(
          appBarTitle: AppConstants.books,
          hintTextSearch: AppConstants.searchBooksByTitle,
          iconSearch: const Icon(
            Icons.book_outlined,
            size: 26,
            color: Colors.black,
          ),
        );
}

class AppStateOnItemsViewCharacters extends AppStateOnItemsView {
  AppStateOnItemsViewCharacters({required super.listOfItems})
      : super(
          appBarTitle: AppConstants.characters,
          hintTextSearch: AppConstants.searchCharactersByName,
          iconSearch: const Icon(
            Icons.people_alt_outlined,
            size: 26,
            color: Colors.black,
          ),
        );
}

class AppStateOnItemsViewSpells extends AppStateOnItemsView {
  AppStateOnItemsViewSpells({required super.listOfItems})
      : super(
          appBarTitle: AppConstants.spells,
          hintTextSearch: AppConstants.searchSpellsByName,
          iconSearch: const Icon(
            Icons.thunderstorm_outlined,
            size: 26,
            color: Colors.black,
          ),
        );
}

class AppStateOnItemsViewSpecies extends AppStateOnItemsView {
  AppStateOnItemsViewSpecies({required super.listOfItems})
      : super(
          appBarTitle: AppConstants.species,
          hintTextSearch: AppConstants.searchSpeciesByName,
          iconSearch: const Icon(
            Icons.forest_outlined,
            size: 26,
            color: Colors.black,
          ),
        );
}

class AppStateOnFavoritesView extends AppState {
  AppStateOnFavoritesView({required super.appBarTitle});
}

class AppStateOnSearchView extends AppState {
  AppStateOnSearchView({required super.appBarTitle});
}

class AppStateOnFeaturedView extends AppState {
  AppStateOnFeaturedView({required super.appBarTitle});
}

class AppStateOnUpdateListViewBooks extends AppStateOnItemsViewBooks {
  AppStateOnUpdateListViewBooks({required super.listOfItems});
}

class AppStateOnUpdateListViewCharacters extends AppStateOnItemsViewCharacters {
  AppStateOnUpdateListViewCharacters({required super.listOfItems});
}

class AppStateOnUpdateListViewSpells extends AppStateOnItemsViewSpells {
  AppStateOnUpdateListViewSpells({required super.listOfItems});
}

class AppStateOnUpdateListViewSpecies extends AppStateOnItemsViewSpecies {
  AppStateOnUpdateListViewSpecies({required super.listOfItems});
}

// Estrategia: minimizar el números de eventos y estados para concentrarlo todo
// en el AppBloc, jugando con los parámetros de los constructores
// La herencia es útil para almacenar sobre un único tipo de estado un mismo atributo

