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

class AppEventPressAll extends AppEvent {
  final String categoryName;
  const AppEventPressAll({required this.categoryName});
}

class AppEventPressRndm extends AppEvent {
  final String categoryName;
  const AppEventPressRndm({required this.categoryName});
}

class AppEventPressAtoZ extends AppEvent {
  final String categoryName;
  final List<dynamic> listOfItems;
  const AppEventPressAtoZ({
    required this.categoryName,
    required this.listOfItems,
  });
}

class AppEventPressZtoA extends AppEvent {
  final String categoryName;
  final List<dynamic> listOfItems;
  const AppEventPressZtoA({
    required this.categoryName,
    required this.listOfItems,
  });
}

class AppEventPressSearch extends AppEvent {
  final String categoryName;
  final String inputText;

  const AppEventPressSearch({
    required this.categoryName,
    required this.inputText,
  });
}

// Si el item no esta en la lista de fav, lo añadiremos, y de lo contrario, lo eliminaremos
class AppEventAddOrRemoveFavItem extends AppEvent {
  final dynamic item;

  const AppEventAddOrRemoveFavItem({
    required this.item,
  });
}
