import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/cloud_constants.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/model_collection/user_collection.dart';

class UserDao {
  final usersCollection = FirebaseFirestore.instance.collection('users');

  static final UserDao _shared = UserDao._sharedInstance();
  UserDao._sharedInstance(); // Private constructor
  factory UserDao() => _shared;

  Future<UserCollection> getUserFromCloudFirebase(String idDocument) async {
    final docSnapshot = await usersCollection.doc(idDocument).get();
    final querySnapshot =
        docSnapshot as QueryDocumentSnapshot<Map<String, dynamic>>;
    return UserCollection.fromSnapshot(querySnapshot);
  }

  Future<UserCollection> insertUser(User user) async {
    final userCollection = UserCollection(
      idDocument: '',
      idFirebase: user.uid,
      email: user.email!,
      isEmailVerified: user.emailVerified,
    );

    final userRef = await usersCollection.add({
      idFirestoreFieldName: userCollection.idFirebase,
      emailFieldName: userCollection.email,
      isEmailVeriFiedFieldName: userCollection.isEmailVerified,
      favoriteBooksFieldName: userCollection.favoriteBooks,
      favoriteCharactersFieldName: userCollection.favoriteCharacters,
      favoriteSpellsFieldName: userCollection.favoriteSpells,
      favoriteSpeciesFieldName: userCollection.favoriteSpecies,
    });

    return getUserFromCloudFirebase(userRef.id);
  }

  Future<void> deleteUser(String idDocument) async {
    await usersCollection.doc(idDocument).delete();
  }
}
