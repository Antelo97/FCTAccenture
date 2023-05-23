import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:harry_potter_app/data/cloud_db/cloud_constants.dart';

@immutable
class BookCollection {
  final String idDocument;
  final int idApiBook;
  final String title;
  final String imageUrl;
  final String author;
  final String releaseDate;

  const BookCollection({
    required this.idDocument,
    required this.idApiBook,
    required this.title,
    required this.imageUrl,
    required this.author,
    required this.releaseDate,
  });

  BookCollection.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : idDocument = snapshot.id,
        idApiBook = snapshot.data()[idApiBookFieldName] as int,
        title = snapshot.data()[titleFieldName] as String,
        imageUrl = snapshot.data()[imageUrlFieldName] as String,
        author = snapshot.data()[authorFieldName] as String,
        releaseDate = snapshot.data()[releaseDateFieldName] as String;
}
