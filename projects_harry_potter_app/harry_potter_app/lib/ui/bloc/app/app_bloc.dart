import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:harry_potter_app/domain/model/auth_user.dart';
import 'package:harry_potter_app/domain/model/book.dart';
import 'package:harry_potter_app/domain/model/character.dart';
import 'package:harry_potter_app/domain/model/species.dart';
import 'package:harry_potter_app/domain/model/spell.dart';
import 'package:harry_potter_app/domain/repository/auth_user_repository.dart';
import 'package:harry_potter_app/domain/repository/book_repository.dart';
import 'package:harry_potter_app/domain/repository/character_repository.dart';
import 'package:harry_potter_app/domain/repository/species_repository.dart';
import 'package:harry_potter_app/domain/repository/spell_repository.dart';
import 'package:harry_potter_app/ui/view/app/app_constants.dart';

import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppStateWelcome(appBarTitle: '')) {
    on<AppEventGoToWelcome>(onAppEventGoToWelcome);
    on<AppEventGoToItems>(onAppEventIntoItems);
    on<AppEventGoToFavorites>(onAppEventIntoFavorites);
    on<AppEventGoToSearch>(onAppEventIntoSearch);
    on<AppEventGoToFeature>(onAppEventGoIntoFeature);
    on<AppEventPressAll>(onAppEventPressAll);
    on<AppEventPressRndm>(onAppEventPressRndm);
    on<AppEventPressAtoZ>(onAppEventPressAtoZ);
    on<AppEventPressZtoA>(onAppEventPressZtoA);
    on<AppEventPressSearch>(onAppEventPressSearch);
    on<AppEventAddOrRemoveFavItem>(onAppEventAddOrRemoveFavItem);
  }

  void onAppEventIntoItems(
      AppEventGoToItems event, Emitter<AppState> emit) async {
    switch (event.categoryName) {
      case AppConstants.books:
        emit(
          AppStateOnItemsViewBooks(
            listOfItems: await BookRepository().getBooksFromCloudFirebase(),
          ),
        );
        break;
      case AppConstants.characters:
        emit(
          AppStateOnItemsViewCharacters(
            listOfItems:
                await CharacterRepository().getCharactersFromCloudFirebase(),
          ),
        );
        break;
      case AppConstants.spells:
        emit(
          AppStateOnItemsViewSpells(
            listOfItems: await SpellRepository().getSpellsFromCloudFirebase(),
          ),
        );
        break;
      case AppConstants.species:
        emit(
          AppStateOnItemsViewSpecies(
            listOfItems:
                await SpeciesRepository().getSpeciesFromCloudFirebase(),
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
    emit(AppStateOnSearchView(appBarTitle: AppConstants.search));
  }

  FutureOr<void> onAppEventGoIntoFeature(
      AppEventGoToFeature event, Emitter<AppState> emit) async {
    emit(
      AppStateOnFeaturedView(
        featuredBooks: await AuthUserRepository().getFeaturedBooks(),
        featuredCharacters: await AuthUserRepository().getFeaturedCharacters(),
        featuredSpells: await AuthUserRepository().getFeaturedSpells(),
        featuredSpecies: await AuthUserRepository().getFeaturedSpeciess(),
      ),
    );
  }

  FutureOr<void> onAppEventPressAll(
      AppEventPressAll event, Emitter<AppState> emit) async {
    switch (event.categoryName) {
      case AppConstants.books:
        final books = await BookRepository().getBooksFromCloudFirebase();
        emit(
          AppStateOnUpdateListViewBooks(listOfItems: books),
        );
        break;
      case AppConstants.characters:
        final characters =
            await CharacterRepository().getCharactersFromCloudFirebase();
        emit(
          AppStateOnUpdateListViewCharacters(listOfItems: characters),
        );
        break;
      case AppConstants.spells:
        final spells = await SpellRepository().getSpellsFromCloudFirebase();
        emit(
          AppStateOnUpdateListViewSpells(listOfItems: spells),
        );
        break;
      case AppConstants.species:
        final species = await SpeciesRepository().getSpeciesFromCloudFirebase();
        emit(
          AppStateOnUpdateListViewSpecies(listOfItems: species),
        );
        break;
    }
  }

  FutureOr<void> onAppEventPressRndm(
      AppEventPressRndm event, Emitter<AppState> emit) async {
    switch (event.categoryName) {
      case AppConstants.books:
        final books = await BookRepository().getBooksFromCloudFirebase();
        final rndm = Random();
        Book rndmBook = books[rndm.nextInt(books.length)];
        books.clear();
        books.add(rndmBook);
        emit(
          AppStateOnUpdateListViewBooks(listOfItems: books),
        );
        break;
      case AppConstants.characters:
        final characters =
            await CharacterRepository().getCharactersFromCloudFirebase();
        final rndm = Random();
        Character rndmCharacter = characters[rndm.nextInt(characters.length)];
        characters.clear();
        characters.add(rndmCharacter);
        emit(
          AppStateOnUpdateListViewCharacters(listOfItems: characters),
        );
        break;
      case AppConstants.spells:
        final spells = await SpellRepository().getSpellsFromCloudFirebase();
        final rndm = Random();
        Spell rndmSpell = spells[rndm.nextInt(spells.length)];
        spells.clear();
        spells.add(rndmSpell);
        emit(
          AppStateOnUpdateListViewSpells(listOfItems: spells),
        );
        break;
      case AppConstants.species:
        final species = await SpeciesRepository().getSpeciesFromCloudFirebase();
        final rndm = Random();
        Species rndmSpecies = species[rndm.nextInt(species.length)];
        species.clear();
        species.add(rndmSpecies);
        emit(
          AppStateOnUpdateListViewSpecies(listOfItems: species),
        );
    }
  }

  FutureOr<void> onAppEventPressAtoZ(
      AppEventPressAtoZ event, Emitter<AppState> emit) async {
    switch (event.categoryName) {
      case AppConstants.books:
        final books = BookRepository()
            .sortBooksByTitleAsc(event.listOfItems as List<Book>);
        emit(
          AppStateOnUpdateListViewBooks(listOfItems: books),
        );
        break;
      case AppConstants.characters:
        final characters = CharacterRepository()
            .sortCharactersByNameAsc(event.listOfItems as List<Character>);
        emit(
          AppStateOnUpdateListViewCharacters(listOfItems: characters),
        );
        break;
      case AppConstants.spells:
        final spells = SpellRepository()
            .sortSpellsByNameAsc(event.listOfItems as List<Spell>);
        emit(
          AppStateOnUpdateListViewSpells(listOfItems: spells),
        );
        break;
      case AppConstants.species:
        final species = SpeciesRepository()
            .sortSpeciesByNameAsc(event.listOfItems as List<Species>);
        emit(
          AppStateOnUpdateListViewSpecies(listOfItems: species),
        );
    }
  }

  FutureOr<void> onAppEventPressZtoA(
      AppEventPressZtoA event, Emitter<AppState> emit) async {
    switch (event.categoryName) {
      case AppConstants.books:
        final books = BookRepository()
            .sortBooksByTitleDesc(event.listOfItems as List<Book>);
        emit(
          AppStateOnUpdateListViewBooks(listOfItems: books),
        );
        break;
      case AppConstants.characters:
        final characters = CharacterRepository()
            .sortCharactersByNameDesc(event.listOfItems as List<Character>);
        emit(
          AppStateOnUpdateListViewCharacters(listOfItems: characters),
        );
        break;
      case AppConstants.spells:
        final spells = SpellRepository()
            .sortSpellsByNameDesc(event.listOfItems as List<Spell>);
        emit(
          AppStateOnUpdateListViewSpells(listOfItems: spells),
        );
        break;
      case AppConstants.species:
        final species = SpeciesRepository()
            .sortSpeciesByNameDesc(event.listOfItems as List<Species>);
        emit(
          AppStateOnUpdateListViewSpecies(listOfItems: species),
        );
    }
  }

  FutureOr<void> onAppEventPressSearch(
      AppEventPressSearch event, Emitter<AppState> emit) async {
    switch (event.categoryName) {
      case AppConstants.books:
        final books =
            await BookRepository().searchBooksByTitle(event.inputText);
        emit(
          AppStateOnUpdateListViewBooks(listOfItems: books),
        );
        break;
      case AppConstants.characters:
        final characters =
            await CharacterRepository().searchCharactersByName(event.inputText);
        emit(
          AppStateOnUpdateListViewCharacters(listOfItems: characters),
        );
        break;
      case AppConstants.spells:
        final spells =
            await SpellRepository().searchSpellsByName(event.inputText);
        emit(
          AppStateOnUpdateListViewSpells(listOfItems: spells),
        );
        break;
      case AppConstants.species:
        final species =
            await SpeciesRepository().searchSpeciesByName(event.inputText);
        emit(
          AppStateOnUpdateListViewSpecies(listOfItems: species),
        );
    }
  }

  FutureOr<void> onAppEventAddOrRemoveFavItem(
      AppEventAddOrRemoveFavItem event, Emitter<AppState> emit) async {
    // Evaluamos el tipo de datos que le llega
    switch (event.item.runtimeType) {
      case Book:
        // Creamos una instancia del item seleccionado (Book, este caso)
        final checkBook = event.item as Book;
        // Extraemos la lista de favoritos de Books para el usuario actual
        final currenUser = await AuthUserRepository()
            .getUserFromCloudFirebase(AuthUser.instance.idFirestore);
        final favBooks = currenUser!.favoriteBooks;
        // Comprobamos si la lista de favoritos de Books contiene el item seleccionado
        if (favBooks.contains(checkBook)) {
          // Si lo contiene, extraemos el usuario, eliminamos dicho item de su listado y lo actualizamos
          final authUser = await AuthUserRepository() // Singleton - factory
              .getUserFromCloudFirebase(
                  AuthUser.instance.idFirestore); // Singleton - get
          authUser!.favoriteBooks
              .removeWhere((book) => book.idApiBook == checkBook.idApiBook);
          await AuthUserRepository().updateUser(authUser);
        } else {
          // Si no lo contiene, extraemos el usuario y agregamos dicho item a su listado y lo actualizamos
          final authUser = await AuthUserRepository()
              .getUserFromCloudFirebase(AuthUser.instance.idFirestore);
          authUser!.favoriteBooks.add(checkBook);
          await AuthUserRepository().updateUser(authUser);
        }

        break;
      case Character:
        final checkCharacter = event.item as Character;
        final currentUser = await AuthUserRepository()
            .getUserFromCloudFirebase(AuthUser.instance.idFirestore);
        final favCharacters = currentUser!.favoriteCharacters;

        if (favCharacters.contains(checkCharacter)) {
          final authUser = await AuthUserRepository()
              .getUserFromCloudFirebase(AuthUser.instance.idFirestore);
          authUser!.favoriteCharacters.removeWhere((character) =>
              character.idApiCharacter == checkCharacter.idApiCharacter);
          await AuthUserRepository().updateUser(authUser);
        } else {
          final authUser = await AuthUserRepository()
              .getUserFromCloudFirebase(AuthUser.instance.idFirestore);
          authUser!.favoriteCharacters.add(checkCharacter);
          await AuthUserRepository().updateUser(authUser);
        }
        break;
      case Spell:
        final checkSpell = event.item as Spell;
        final currentUser = await AuthUserRepository()
            .getUserFromCloudFirebase(AuthUser.instance.idFirestore);
        final favSpells = currentUser!.favoriteSpells;

        if (favSpells.contains(checkSpell)) {
          final authUser = await AuthUserRepository()
              .getUserFromCloudFirebase(AuthUser.instance.idFirestore);
          authUser!.favoriteSpells.removeWhere(
              (spell) => spell.idApiSpell == checkSpell.idApiSpell);
          await AuthUserRepository().updateUser(authUser);
        } else {
          final authUser = await AuthUserRepository()
              .getUserFromCloudFirebase(AuthUser.instance.idFirestore);
          authUser!.favoriteSpells.add(checkSpell);
          await AuthUserRepository().updateUser(authUser);
        }
        break;
      case Species:
        final checkSpecies = event.item as Species;
        final currentUser = await AuthUserRepository()
            .getUserFromCloudFirebase(AuthUser.instance.idFirestore);
        final favSpecies = currentUser!.favoriteSpecies;

        if (favSpecies.contains(checkSpecies)) {
          final authUser = await AuthUserRepository()
              .getUserFromCloudFirebase(AuthUser.instance.idFirestore);
          authUser!.favoriteSpecies.removeWhere(
              (species) => species.idApiSpecies == checkSpecies.idApiSpecies);
          await AuthUserRepository().updateUser(authUser);
        } else {
          final authUser = await AuthUserRepository()
              .getUserFromCloudFirebase(AuthUser.instance.idFirestore);
          authUser!.favoriteSpecies.add(checkSpecies);
          await AuthUserRepository().updateUser(authUser);
        }
    }
  }

  FutureOr<void> onAppEventGoToWelcome(
      AppEventGoToWelcome event, Emitter<AppState> emit) {
    emit(AppStateWelcome());
  }
}
