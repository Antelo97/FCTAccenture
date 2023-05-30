import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/cloud_constants.dart';
import 'package:harry_potter_app/domain/model/auth_user.dart';

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

  Future<AuthUser> insertUser(AuthUser authUser) async {
    await usersCollection.add({
      idFirebaseFieldName: authUser.idFirestore,
      emailFieldName: authUser.email,
      isEmailVerifiedFieldName: authUser.isEmailVerified,
      usernameFieldName: authUser.username,
      favoriteBooksFieldName:
          authUser.favoriteBooks.map((book) => book.toMap()).toList(),
      favoriteCharactersFieldName: authUser.favoriteCharacters
          .map((character) => character.toMap())
          .toList(),
      favoriteSpellsFieldName:
          authUser.favoriteSpells.map((spell) => spell.toMap()).toList(),
      favoriteSpeciesFieldName:
          authUser.favoriteSpecies.map((species) => species.toMap()).toList(),
    });

    // user.uid --> Atributo del usuario interno de Firestore, lo almaceno en la colección en el campo id_firestore
    // userRef.id --> Es la referencia que tiene un documento dentro de la colección en Firebase (también es una String)

    final insertedUser = await getUserFromCloudFirebase(authUser.idFirestore);
    return insertedUser!;
  }

  Future<void> updateUser(AuthUser user) async {
    final document = await usersCollection.doc(user.idDocument).get();
    if (document.exists) {
      await usersCollection.doc(user.idDocument).update({
        idFirebaseFieldName: user.idFirestore,
        emailFieldName: user.email,
        isEmailVerifiedFieldName: user.isEmailVerified,
        usernameFieldName: user.username,
        favoriteBooksFieldName: user.favoriteBooks,
        favoriteCharactersFieldName: user.favoriteCharacters,
        favoriteSpellsFieldName: user.favoriteSpells,
        favoriteSpeciesFieldName: user.favoriteSpecies,
      });
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
}
