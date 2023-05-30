import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AppEvent {
  const AppEvent();
}

class AppEventGoToBooks extends AppEvent {}

class AppEventGoToCharacters extends AppEvent {}

class AppEventGoToSpells extends AppEvent {}

class AppEventGoToSpecies extends AppEvent {}

class AppEventGoToFavorites extends AppEvent {}

class AppEventGoToSearch extends AppEvent {}

class AppEventGoToFeature extends AppEvent {}
