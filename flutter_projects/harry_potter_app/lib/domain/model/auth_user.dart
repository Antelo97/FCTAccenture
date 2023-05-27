import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/cloud_constants.dart';

import 'book.dart';
import 'character.dart';
import 'species.dart';
import 'spell.dart';

class AuthUser {
  String idDocument = '';
  final String idFirestore;
  final String email;
  final bool isEmailVerified;
  final String username;
  List<Book> favoriteBooks = [];
  List<Character> favoriteCharacters = [];
  List<Spell> favoriteSpells = [];
  List<Species> favoriteSpecies = [];
  AuthUser({
    required this.idFirestore,
    required this.email,
    required this.isEmailVerified,
    required this.username,
  });

  AuthUser.fromFirebase(User user)
      : idFirestore = user.uid,
        email = user.email!,
        isEmailVerified = user.emailVerified,
        username = '';

  AuthUser.fromDocument(QueryDocumentSnapshot<Map<String, dynamic>> document)
      : idDocument = document.id,
        idFirestore = document.data()[idFirestoreFieldName] as String,
        email = document.data()[emailFieldName] as String,
        isEmailVerified = document.data()[isEmailVeriFiedFieldName] as bool,
        username = document.data()[usernameFieldName] as String,
        favoriteBooks = document.data()[favoriteBooksFieldName] as List<Book>,
        favoriteCharacters =
            document.data()[favoriteCharactersFieldName] as List<Character>,
        favoriteSpells =
            document.data()[favoriteSpellsFieldName] as List<Spell>,
        favoriteSpecies =
            document.data()[favoriteSpeciesFieldName] as List<Species>;
}

// factory UserCollection.fromFirebase(User user) => UserCollection(
  //       idDocument: '',
  //       idFirebase: user.uid,
  //       email: user.email!,
  //       isEmailVerified: user.emailVerified,
  //     );
