import 'package:bloc/bloc.dart';

import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppStateZero()) {
    on<AppEventGoToBooks>(onAppEventGoToBooks);
    on<AppEventGoToCharacters>(onAppEventGoToCharacters);
    on<AppEventGoToSpells>(onAppEventGoToSpells);
    on<AppEventGoToSpecies>(onAppEventGoToSpecies);
  }

  void onAppEventGoToBooks(AppEventGoToBooks event, Emitter<AppState> emit) {
    emit(const AppStateOnBooksView());
  }

  void onAppEventGoToCharacters(
      AppEventGoToCharacters event, Emitter<AppState> emit) {
    emit(const AppStateOnCharactersView());
  }

  void onAppEventGoToSpells(AppEventGoToSpells event, Emitter<AppState> emit) {
    emit(const AppStateOnSpellsView());
  }

  void onAppEventGoToSpecies(
      AppEventGoToSpecies event, Emitter<AppState> emit) {
    emit(const AppStateOnSpeciesView());
  }
}
