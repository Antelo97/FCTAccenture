// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:harry_potter_app/domain/model/book.dart';
// import 'package:harry_potter_app/domain/repository/book_repository.dart';
// import 'package:harry_potter_app/ui/bloc/app/app_bloc.dart';
// import 'package:harry_potter_app/ui/bloc/app/app_state.dart';

// class BooksView extends StatefulWidget {
//   const BooksView({super.key});

//   @override
//   State<BooksView> createState() => _BooksViewState();
// }

// class _BooksViewState extends State<BooksView> {
//   final _bookRepository = BookRepository();
//   late final TextEditingController _searchController;
//   // late final List<Book> books;

//   @override
//   void initState() {
//     _searchController = TextEditingController();
//     // books = await _bookRepository.loadBooksFromApi();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     String _searchItems = '';
//     return Stack(
//       children: [
//         BlocListener<AppBloc, AppState>(
//           listener: (context, state) {
//             // recoge eveneto de pulsación para actualizar la lista y llamar al método update books
//           },
//           child: Container(
//             padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     onChanged: (value) {
//                       setState(() {
//                         //searchText = value;
//                       });
//                     },
//                     decoration: InputDecoration(
//                       hintText: _searchItems,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 8.0),
//                 IconButton(
//                   onPressed: () {
//                     //search();
//                   },
//                   icon: Icon(Icons.search),
//                 ),
//               ],
//             ),
//           ),
//         ),

//         // getListViewBooks(books)
//       ],
//     );
//   }
// }

// Widget getListViewBooks(List<Book> books) {
//   return ListView.builder(
//     itemCount: books.length,
//     itemBuilder: (context, index) {
//       final book = books.elementAt(index);
//       return ListTile(
//         onTap: () {
//           // onTap(note);
//         },
//         title: Text(
//           book.title,
//           maxLines: 1,
//           softWrap: true,
//           overflow: TextOverflow.ellipsis,
//         ),
//         trailing: IconButton(
//           onPressed: () async {
//             // final shouldDelete = await showDeleteDialog(context);
//             // if (shouldDelete) {
//             //   onDeleteNote(note);
//             // }
//           },
//           icon: const Icon(Icons.delete),
//         ),
//       );
//     },
//   );
// }
