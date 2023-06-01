abstract class AppEvent {
  const AppEvent();
}

// items_view.dart
class AppEventGoToItems extends AppEvent {
  final String categoryName;
  AppEventGoToItems({required this.categoryName});
}

// ---
class AppEventGoToFavorites extends AppEvent {
  const AppEventGoToFavorites();
}

// ---
class AppEventGoToSearch extends AppEvent {
  const AppEventGoToSearch();
}

// ---
class AppEventGoToFeature extends AppEvent {
  const AppEventGoToFeature();
}
