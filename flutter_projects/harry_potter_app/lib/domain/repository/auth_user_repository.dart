import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/cloud_constants.dart';
import 'package:harry_potter_app/domain/model/auth_user.dart';
import 'package:harry_potter_app/domain/model/book.dart';
import 'package:harry_potter_app/domain/model/character.dart';
import 'package:harry_potter_app/domain/model/species.dart';
import 'package:harry_potter_app/domain/model/spell.dart';

class AuthUserRepository {
  final usersCollection = FirebaseFirestore.instance.collection('users');

  static final AuthUserRepository _shared =
      AuthUserRepository._sharedInstance();
  AuthUserRepository._sharedInstance(); // Private constructor
  factory AuthUserRepository() => _shared;

  Future<AuthUser?> getUserFromCloudFirebase(String idFirebase) async {
    final authUser = await usersCollection
        .where(idFirebaseFieldName, isEqualTo: idFirebase)
        .get()
        .then((snapshot) =>
            snapshot.docs.map((doc) => AuthUser.fromDocument(doc)).first);
    return authUser;
  }

  Stream<AuthUser> getStreamUserFromCloudFirebase() {
    // Lo ideal sería filtrar con el idDocument en vez del idFirebase, que require
    // hacer el where, pero en el primer caso obtenemos un DocumentSnapshot, y el
    // método fromDocument de AuthUser recibe como parámetro un QueryDocumentSnapshot
    final idFirebase = AuthUser.instance.idFirestore;
    return usersCollection
        .where(
          idFirebaseFieldName,
          isEqualTo: idFirebase,
        )
        .snapshots()
        .map(
            (snap) => snap.docs.map((doc) => AuthUser.fromDocument(doc)).first);
  }

  Future<AuthUser> insertUser(AuthUser authUser) async {
    await usersCollection.add(authUser.toMap());
    deleteDefaultEmptyDocument();

    // user.uid --> Atributo del usuario interno de Firestore, lo almaceno en la colección en el campo id_firestore
    // userRef.id --> Es la referencia que tiene un documento dentro de la colección en Firebase (también es una String)

    final insertedUser = await getUserFromCloudFirebase(authUser.idFirestore);
    return insertedUser!;
  }

  Future<void> updateUser(AuthUser user) async {
    final document = await usersCollection.doc(user.idDocument).get();
    if (document.exists) {
      await usersCollection.doc(user.idDocument).update(user.toMap());
    }
  }

  Future<void> updateIsEmailVerified(AuthUser user) async {
    final document = await usersCollection.doc(user.idDocument).get();
    if (document.exists) {
      if (document.data()![isEmailVerifiedFieldName] != user.isEmailVerified) {
        await usersCollection.doc(user.idDocument).update({
          isEmailVerifiedFieldName: user.isEmailVerified,
        });
      }
    }
  }

  Future<void> deleteUser(String idDocument) async {
    await usersCollection.doc(idDocument).delete();
  }

  void deleteDefaultEmptyDocument() async {
    final snapshot = await usersCollection.get();

    for (var doc in snapshot.docs) {
      final data = doc.data();

      if (data.isEmpty) {
        await doc.reference.delete();
      }
    }
  }

  // Stream<List<Book>> getStreamFavoriteBooks(String idFirebase) {
  //   return usersCollection
  //       .where(
  //         idFirebaseFieldName,
  //         isEqualTo: idFirebase,
  //       )
  //       .snapshots()
  //       .map((snap) => snap.docs.map((doc) => Book.fromDocument(doc)).toList());
  // }

  // Future<List<Book>> getFavoriteBooks(String idFirebase) async {
  //   final currentUser = await getUserFromCloudFirebase(idFirebase);
  //   return currentUser!.favoriteBooks;
  // }

  // Stream<List<Character>> getStreamFavoriteCharacters(String idFirebase) {
  //   return usersCollection
  //       .where(
  //         idFirebaseFieldName,
  //         isEqualTo: idFirebase,
  //       )
  //       .snapshots()
  //       .map((snap) => snap.docs
  //           .map((doc) =>
  //               Character.fromDocument(doc.data()[favoriteCharactersFieldName]))
  //           .toList());
  // }

  // Future<List<Character>> getFavoriteCharacters(String idFirebase) async {
  //   final currentUser = await getUserFromCloudFirebase(idFirebase);
  //   return currentUser!.favoriteCharacters;
  // }

  // Stream<List<Spell>> getStreamFavoriteSpells(String idFirebase) {
  //   return usersCollection
  //       .where(
  //         idFirebaseFieldName,
  //         isEqualTo: idFirebase,
  //       )
  //       .snapshots()
  //       .map((snap) => snap.docs
  //           .map((doc) =>
  //               Spell.fromDocument(doc.data()[favoriteSpellsFieldName]))
  //           .toList());
  // }

  // Future<List<Spell>> getFavoriteSpells(String idFirebase) async {
  //   final currentUser = await getUserFromCloudFirebase(idFirebase);
  //   return currentUser!.favoriteSpells;
  // }

  // Stream<List<Species>> getStreamFavoriteSpecies(String idFirebase) {
  //   return usersCollection
  //       .where(
  //         idFirebaseFieldName,
  //         isEqualTo: idFirebase,
  //       )
  //       .snapshots()
  //       .map((snap) => snap.docs
  //           .map((doc) =>
  //               Species.fromDocument(doc.data()[favoriteSpeciesFieldName]))
  //           .toList());
  // }

  // Future<List<Species>> getFavoriteSpecies(String idFirebase) async {
  //   final currentUser = await getUserFromCloudFirebase(idFirebase);
  //   return currentUser!.favoriteSpecies;
  // }
}
