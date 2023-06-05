abstract class AppEvent {
  const AppEvent();
}

// welcome_view.dart
class AppEventGoToWelcome extends AppEvent {
  AppEventGoToWelcome();
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

// En los Event de los Bloc no hay tanta tendencia a las herencias, ya que la confluencia
// se va a gestar en el Bloc a través de la emisión de estados relacionados por herencia
// * Esto no implica que sea posible minimizar el número de estados a través de la generación
// de estados que reciban varios parámetros. No obstante, puedes ser preferible varios
// eventos distintos para hacerlo más visual. 
// * Un evento sin parámetros solo va a permitir al Bloc emitir un único estado
// * Un evento con un paramétro de tipo String va a permitir al Bloc emitir múltiples
// estados en función de la String (if/switch), por lo tanto, un evento con múltiples parámetros
// se puede concebir como un evento que engloba varios eventos dentro de si