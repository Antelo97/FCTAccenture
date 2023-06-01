import 'package:flutter/material.dart';

abstract class AppState {
  const AppState();
}

abstract class AppStateNavigate extends AppState {
  final String appBarTitle;
  const AppStateNavigate({required this.appBarTitle});
}

// Estado inerte para inicializar al AppBloc
class AppStateZero extends AppState {
  const AppStateZero() : super();
}

class AppStateOnItemsView extends AppStateNavigate {
  final String hintTextSearch;
  final Icon iconSearch;
  final List<dynamic> listOfItems;

  const AppStateOnItemsView({
    required super.appBarTitle,
    required this.hintTextSearch,
    required this.iconSearch,
    required this.listOfItems,
  });
}

class AppStateOnFavoritesView extends AppStateNavigate {
  AppStateOnFavoritesView({required super.appBarTitle});
}

class AppStateOnSearchView extends AppStateNavigate {
  AppStateOnSearchView({required super.appBarTitle});
}

class AppStateOnFeaturedView extends AppStateNavigate {
  AppStateOnFeaturedView({required super.appBarTitle});
}


// Estrategia: minimizar el números de eventos y estados para concentrarlo todo
// en el AppBloc, jugando con los parámetros de los constructores
// La herencia es útil para almacenar sobre un único tipo de estado un mismo atributo

// class AppStateOnBooksCategory extends AppStateOnItemsView {
//   const AppStateOnBooksCategory({required listOfItems})
//       : super(
//           appBarTitle: AppConstants.books,
//           hintTextSearch: AppConstants.searchBooksByTitle,
//           iconSearch: const Icon(
//             Icons.book_outlined,
//             size: 26,
//             color: Colors.black,
//           ),
//           listOfItems: listOfItems,
//         );
// }

// class AppStateOnCharactersCategory extends AppStateOnItemsView {
//   const AppStateOnCharactersCategory({required listOfItems})
//       : super(
//           appBarTitle: AppConstants.characters,
//           hintTextSearch: AppConstants.searchCharactersByName,
//           iconSearch: const Icon(
//             Icons.people_alt_outlined,
//             size: 26,
//             color: Colors.black,
//           ),
//           listOfItems: listOfItems,
//         );
// }

// class AppStateOnSpellsCategory extends AppStateOnItemsView {
//   const AppStateOnSpellsCategory({required listOfItems})
//       : super(
//           appBarTitle: AppConstants.spells,
//           hintTextSearch: AppConstants.searchSpellsByName,
//           iconSearch: const Icon(
//             Icons.thunderstorm_outlined,
//             size: 26,
//             color: Colors.black,
//           ),
//           listOfItems: listOfItems,
//         );
// }

// class AppStateOnSpeciesCategory extends AppStateOnItemsView {
//   const AppStateOnSpeciesCategory({required listOfItems})
//       : super(
//           appBarTitle: AppConstants.species,
//           hintTextSearch: AppConstants.searchSpeciesByName,
//           iconSearch: const Icon(
//             Icons.forest_outlined,
//             size: 26,
//             color: Colors.black,
//           ),
//           listOfItems: listOfItems,
//         );
// }
