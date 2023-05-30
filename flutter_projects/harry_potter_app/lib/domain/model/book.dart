import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/cloud_constants.dart';
import 'package:harry_potter_app/data/network/model_response/book_response.dart';

class Book {
  String? idDocument;
  final int idApiBook;
  final String title;
  final String imageUrl;
  final String author;
  final String releaseDate;

  Book({
    required this.idDocument,
    required this.idApiBook,
    required this.title,
    required this.imageUrl,
    required this.author,
    required this.releaseDate,
  });

  Book.fromDocument(QueryDocumentSnapshot<Map<String, dynamic>> document)
      : idDocument = document.id,
        idApiBook = document.data()[idApiBookFieldName] as int,
        title = document.data()[titleFieldName] as String,
        imageUrl = document.data()[imageUrlFieldName] as String,
        author = document.data()[authorFieldName] as String,
        releaseDate = document.data()[releaseDateFieldName] as String;

  Book.fromResponse(BookResponse book)
      : idApiBook = book.idApi,
        title = book.title,
        imageUrl = book.imageUrl,
        author = book.artists[0].author.name,
        releaseDate = book.releaseDate;

  Book.fromMap(Map<String, dynamic> map)
      : idApiBook = map[idApiBookFieldName] as int,
        title = map[titleFieldName] as String,
        imageUrl = map[imageUrlFieldName] as String,
        author = map[authorFieldName] as String,
        releaseDate = map[releaseDateFieldName] as String;

  Map<String, dynamic> toMap() {
    return {
      idApiBookFieldName: idApiBook,
      titleFieldName: title,
      imageUrlFieldName: imageUrl,
      authorFieldName: author,
      releaseDateFieldName: releaseDate,
    };
  }
}
