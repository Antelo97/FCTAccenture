import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/cloud_constants.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/model_collection/book_collection.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/model_collection/character_collection.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/model_collection/species_collection.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/model_collection/spell_collection.dart';

@immutable
class UserCollection {
  final String idDocument;
  final String idFirestore;
  final String email;
  final bool isEmailVerified;
  final List<BookCollection> favoriteBooks = [];
  final List<CharacterCollection> favoriteCharacters = [];
  final List<SpellCollection> favoriteSpells = [];
  final List<SpeciesCollection> favoriteSpecies = [];
  UserCollection({
    required this.idDocument,
    required this.idFirestore,
    required this.email,
    required this.isEmailVerified,
  });

  // factory UserCollection.fromFirebase(User user) => UserCollection(
  //       idDocument: '',
  //       idFirebase: user.uid,
  //       email: user.email!,
  //       isEmailVerified: user.emailVerified,
  //     );

  UserCollection.fromFirebase(User user)
      : idDocument = '',
        idFirestore = user.uid,
        email = user.email!,
        isEmailVerified = user.emailVerified;

  UserCollection.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : idDocument = snapshot.id,
        idFirestore = snapshot.data()[idFirestoreFieldName] as String,
        email = snapshot.data()[emailFieldName] as String,
        isEmailVerified = snapshot.data()[isEmailVeriFiedFieldName] as bool;
}
