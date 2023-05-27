import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/cloud_constants.dart';
import 'package:harry_potter_app/data/network/model_response/book_response.dart';

@immutable
class Book {
  final String idDocument;
  final int idApiBook;
  final String title;
  final String imageUrl;
  final String author;
  final String releaseDate;

  const Book({
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
      : idDocument = '',
        idApiBook = book.idApi,
        title = book.title,
        imageUrl = book.imageUrl,
        author = book.artists[0].author.name,
        releaseDate = book.releaseDate;
}
