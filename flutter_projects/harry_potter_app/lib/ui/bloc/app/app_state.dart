import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AppState {
  const AppState();
}

class AppStateZero extends AppState {
  const AppStateZero();
}

class AppStateOnBooksView extends AppState {
  const AppStateOnBooksView();
}

class AppStateOnCharactersView extends AppState {
  const AppStateOnCharactersView();
}

class AppStateOnSpellsView extends AppState {
  const AppStateOnSpellsView();
}

class AppStateOnSpeciesView extends AppState {
  const AppStateOnSpeciesView();
}
