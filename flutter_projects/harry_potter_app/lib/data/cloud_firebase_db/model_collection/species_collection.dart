import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/cloud_constants.dart';

@immutable
class SpeciesCollection {
  final String idDocument;
  final int idApiSpecies;
  final String name;
  final String? native;
  final String imageUrl;

  const SpeciesCollection(
      {required this.idDocument,
      required this.idApiSpecies,
      required this.name,
      required this.native,
      required this.imageUrl});

  SpeciesCollection.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : idDocument = snapshot.id,
        idApiSpecies = snapshot.data()[idApiSpeciesFieldName] as int,
        name = snapshot.data()[nameFieldName] as String,
        native = snapshot.data()[nativeFieldName] as String?,
        imageUrl = snapshot.data()[imageUrlFieldName] as String;
}
