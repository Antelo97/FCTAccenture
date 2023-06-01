import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:harry_potter_app/domain/repository/book_repository.dart';
import 'package:harry_potter_app/domain/repository/character_repository.dart';
import 'package:harry_potter_app/domain/repository/species_repository.dart';
import 'package:harry_potter_app/domain/repository/spell_repository.dart';
import 'package:harry_potter_app/ui/view/app/app_constants.dart';

import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final bookRepository = BookRepository();
  final characterRepository = CharacterRepository();
  final spellRepository = SpellRepository();
  final speciesRepository = SpeciesRepository();

  AppBloc() : super(const AppStateZero()) {
    on<AppEventGoToItems>(onAppEventIntoItems);
    on<AppEventGoToFavorites>(onAppEventIntoFavorites);
    on<AppEventGoToSearch>(onAppEventIntoSearch);
    on<AppEventGoToFeature>(onAppEventGoIntoFeature);
  }

  void onAppEventIntoItems(
      AppEventGoToItems event, Emitter<AppState> emit) async {
    switch (event.categoryName) {
      case AppConstants.books:
        emit(
          AppStateOnItemsView(
            appBarTitle: AppConstants.books,
            hintTextSearch: AppConstants.searchBooksByTitle,
            iconSearch: const Icon(
              Icons.book_outlined,
              size: 26,
              color: Colors.black,
            ),
            listOfItems: await bookRepository.getBooksFromCloudFirebase(),
          ),
        );
        break;
      case AppConstants.characters:
        emit(
          AppStateOnItemsView(
            appBarTitle: AppConstants.characters,
            hintTextSearch: AppConstants.searchCharactersByName,
            iconSearch: const Icon(
              Icons.people_alt_outlined,
              size: 26,
              color: Colors.black,
            ),
            listOfItems:
                await characterRepository.getCharactersFromCloudFirebase(),
          ),
        );
        break;
      case AppConstants.spells:
        emit(
          AppStateOnItemsView(
            appBarTitle: AppConstants.spells,
            hintTextSearch: AppConstants.searchSpellsByName,
            iconSearch: const Icon(
              Icons.thunderstorm_outlined,
              size: 26,
              color: Colors.black,
            ),
            listOfItems: await spellRepository.getSpellsFromCloudFirebase(),
          ),
        );
        break;
      case AppConstants.species:
        emit(
          AppStateOnItemsView(
            appBarTitle: AppConstants.species,
            hintTextSearch: AppConstants.searchSpeciesByName,
            iconSearch: const Icon(
              Icons.forest_outlined,
              size: 26,
              color: Colors.black,
            ),
            listOfItems: await speciesRepository.getSpeciesFromCloudFirebase(),
          ),
        );
        break;
    }
  }

  FutureOr<void> onAppEventIntoFavorites(
      AppEventGoToFavorites event, Emitter<AppState> emit) {
    emit(AppStateOnFavoritesView(appBarTitle: AppConstants.favorites));
  }

  FutureOr<void> onAppEventIntoSearch(
      AppEventGoToSearch event, Emitter<AppState> emit) {
    emit(AppStateOnFavoritesView(appBarTitle: AppConstants.search));
  }

  FutureOr<void> onAppEventGoIntoFeature(
      AppEventGoToFeature event, Emitter<AppState> emit) {
    emit(AppStateOnFeaturedView(appBarTitle: AppConstants.featured));
  }
}
