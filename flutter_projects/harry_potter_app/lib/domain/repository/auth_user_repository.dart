import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/cloud_constants.dart';
import 'package:harry_potter_app/domain/model/auth_user.dart';

class AuthUserRepository {
  final usersCollection = FirebaseFirestore.instance.collection('users');

  static final AuthUserRepository _shared =
      AuthUserRepository._sharedInstance();
  AuthUserRepository._sharedInstance(); // Private constructor
  factory AuthUserRepository() => _shared;

  Future<AuthUser?> getUserFromCloudFirebase(String idFirebase) async {
    return await usersCollection
        .where(idFirestoreFieldName, isEqualTo: idFirebase)
        .get()
        .then((snapshot) =>
            snapshot.docs.map((doc) => AuthUser.fromDocument(doc)).first);
  }

  Future<AuthUser> insertUser(User user) async {
    final userRef = await usersCollection.add({
      idFirestoreFieldName: user.uid,
      emailFieldName: user.email,
      isEmailVeriFiedFieldName: user.emailVerified,
      favoriteBooksFieldName: [],
      favoriteCharactersFieldName: [],
      favoriteSpellsFieldName: [],
      favoriteSpeciesFieldName: [],
    });

    // user.uid --> atributo del usuario interno de Firestore, lo almaceno en la colección en el campo id_firestore
    // userRef.id --> es la referencia que tiene l documento dentro de la colección en Firebase
    final insertedUser = await getUserFromCloudFirebase(user.uid);

    return insertedUser!;
  }

  Future<void> deleteUser(String idDocument) async {
    await usersCollection.doc(idDocument).delete();
  }
}
