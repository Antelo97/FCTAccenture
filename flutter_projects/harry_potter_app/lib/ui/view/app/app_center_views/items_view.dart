import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter_app/domain/model/book.dart';
import 'package:harry_potter_app/domain/model/character.dart';
import 'package:harry_potter_app/domain/model/species.dart';
import 'package:harry_potter_app/domain/model/spell.dart';
import 'package:harry_potter_app/domain/repository/book_repository.dart';
import 'package:harry_potter_app/ui/bloc/app/app_bloc.dart';
import 'package:harry_potter_app/ui/bloc/app/app_state.dart';

class ItemsView extends StatefulWidget {
  final AppStateOnItemsView state;

  const ItemsView({
    required this.state,
    super.key,
  });

  @override
  State<ItemsView> createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> {
  late final BookRepository _bookRepository;
  late final TextEditingController _searchController;
  final double _radius = 8.0;
  List<dynamic> _listOfItems = [];
  String _hintTextSearch = '';
  Icon _iconSearch = const Icon(Icons.abc);

  @override
  void initState() {
    _hintTextSearch = widget.state.hintTextSearch;
    _iconSearch = widget.state.iconSearch;
    _listOfItems = widget.state.listOfItems;

    _bookRepository = BookRepository();
    _searchController = TextEditingController();
    // books = await _bookRepository.loadBooksFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        _searchController.clear();
        if (state is AppStateOnItemsView) {
          setState(() {
            _hintTextSearch = state.hintTextSearch;
            _iconSearch = state.iconSearch;
            _listOfItems = state.listOfItems;
          });
        }
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 30, 16, 10),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(1),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                textAlign: TextAlign.start,
                cursorColor: Colors.black,
                style: const TextStyle(
                  letterSpacing: 1,
                  fontSize: 12,
                  fontFamily: 'Apple Days',
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(14, 14, 0, 14),
                  prefixIcon: _iconSearch,
                  suffixIcon: IconButton(
                    onPressed: () {
                      //search();
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 26,
                      color: Colors.black,
                    ),
                  ),
                  hintText: _hintTextSearch,
                  hintStyle: const TextStyle(
                    letterSpacing: 1,
                    color: Colors.black38,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Apple Butter',
                  ),
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(_radius),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) {
                  setState(() {
                    //searchText = value;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: getListView(_listOfItems),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

Widget getListView(List<dynamic> listOfItems) {
  if (listOfItems is List<Book>) {
    return getListViewBook(listOfItems);
  } else if (listOfItems is List<Character>) {
    return getListViewCharacters(listOfItems);
  } else if (listOfItems is List<Spell>) {
    return getListViewSpells(listOfItems);
  } else if (listOfItems is List<Species>) {
    return getListViewSpecies(listOfItems);
  } else {
    return Container();
  }
}

Widget getListViewBook(List<Book> books) {
  return ListView.builder(
    itemCount: books.length,
    itemBuilder: (context, index) {
      final item = books.elementAt(index);
      return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            width: 1000,
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Colors.black, width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 3,
                  blurRadius: 14,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            title: Text(
              item.title,
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              onPressed: () async {},
              icon: const Icon(Icons.delete),
            ),
          ),
        ],
      );
    },
  );
}

Widget getListViewCharacters(List<Character> characters) {
  return ListView.builder(
    itemCount: characters.length,
    itemBuilder: (context, index) {
      final item = characters.elementAt(index);
      return ListTile(
        onTap: () {},
        title: Text(
          item.name,
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          onPressed: () async {},
          icon: const Icon(Icons.delete),
        ),
      );
    },
  );
}

Widget getListViewSpells(List<Spell> spells) {
  return ListView.builder(
    itemCount: spells.length,
    itemBuilder: (context, index) {
      final item = spells.elementAt(index);
      return ListTile(
        onTap: () {},
        title: Text(
          item.name,
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          onPressed: () async {},
          icon: const Icon(Icons.delete),
        ),
      );
    },
  );
}

Widget getListViewSpecies(List<Species> species) {
  return ListView.builder(
    itemCount: species.length,
    itemBuilder: (context, index) {
      final item = species.elementAt(index);
      return ListTile(
        onTap: () {},
        title: Text(
          item.name,
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          onPressed: () async {},
          icon: const Icon(Icons.delete),
        ),
      );
    },
  );
}
