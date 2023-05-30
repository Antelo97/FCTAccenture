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
        idFirestore = document.data()[idFirebaseFieldName] as String,
        email = document.data()[emailFieldName] as String,
        isEmailVerified = document.data()[isEmailVerifiedFieldName] as bool,
        username = document.data()[usernameFieldName] as String,
        favoriteBooks = _convertToBookList(
            document.data()[favoriteBooksFieldName] as List<dynamic>),
        favoriteCharacters = _convertToCharacterList(
            document.data()[favoriteCharactersFieldName] as List<dynamic>),
        favoriteSpells = _convertToSpellList(
            document.data()[favoriteSpellsFieldName] as List<dynamic>),
        favoriteSpecies = _convertToSpeciesList(
            document.data()[favoriteSpeciesFieldName] as List<dynamic>);
}

List<Book> _convertToBookList(List<dynamic> list) {
  return list
      .map((item) => Book.fromMap(item as Map<String, dynamic>))
      .toList();
}

List<Character> _convertToCharacterList(List<dynamic> list) {
  return list
      .map((item) => Character.fromMap(item as Map<String, dynamic>))
      .toList();
}

List<Spell> _convertToSpellList(List<dynamic> list) {
  return list
      .map((item) => Spell.fromMap(item as Map<String, dynamic>))
      .toList();
}

List<Species> _convertToSpeciesList(List<dynamic> list) {
  return list
      .map((item) => Species.fromMap(item as Map<String, dynamic>))
      .toList();
}

// factory UserCollection.fromFirebase(User user) => UserCollection(
//       idDocument: '',
//       idFirebase: user.uid,
//       email: user.email!,
//       isEmailVerified: user.emailVerified,
//     );
