import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/cloud_constants.dart';

@immutable
class SpellCollection {
  final String idDocument;
  final String idApiSpell;
  final String name;
  final String description;
  final String imageUrl;

  const SpellCollection({
    required this.idDocument,
    required this.idApiSpell,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  SpellCollection.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : idDocument = snapshot.id,
        idApiSpell = snapshot.data()[idApiSpellFieldName] as String,
        name = snapshot.data()[nameFieldName] as String,
        description = snapshot.data()[descriptionFieldName] as String,
        imageUrl = snapshot.data()[imageUrlFieldName] as String;
}
