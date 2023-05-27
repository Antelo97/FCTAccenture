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
  bool isEmailVerified;
  final String username;
  List<Book> favoriteBooks = [];
  List<Character> favoriteCharacters = [];
  List<Spell> favoriteSpells = [];
  List<Species> favoriteSpecies = [];

  // 1. ( ) --> Parámetros obligatorios, sin nombres
  // 2. {( )} --> Permite añadir parámetros opcionales, con nombres
  //    a) {(this.)} --> Opcional
  //    b) {(required this.)} --> Obligatorio

  // final: valor inmutable
  // * Si definimos la variable a nivel de atributo, no podremos hacerlo a nivel de constructor

  AuthUser.fromFirebase(
    User user,
    this.username,
  )   : idFirestore = user.uid,
        email = user.email!,
        isEmailVerified = user.emailVerified;

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
