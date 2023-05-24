import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/cloud_constants.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/model_collection/user_collection.dart';

class UserDao {
  final usersCollection = FirebaseFirestore.instance.collection('users');

  static final UserDao _shared = UserDao._sharedInstance();
  UserDao._sharedInstance(); // Private constructor
  factory UserDao() => _shared;

  Future<UserCollection> getUserFromCloudFirebase(String idFirebase) async {
    return await usersCollection
        .where(idFirestoreFieldName, isEqualTo: idFirebase)
        .get()
        .then((snapshot) =>
            snapshot.docs.map((doc) => UserCollection.fromSnapshot(doc)).first);
  }

  Future<UserCollection> insertUser(User user) async {
    final userRef = await usersCollection.add({
      idFirestoreFieldName: user.uid,
      emailFieldName: user.email,
      isEmailVeriFiedFieldName: user.emailVerified,
      favoriteBooksFieldName: [],
      favoriteCharactersFieldName: [],
      favoriteSpellsFieldName: [],
      favoriteSpeciesFieldName: [],
    });

    return getUserFromCloudFirebase(userRef.id);
  }

  Future<void> deleteUser(String idDocument) async {
    await usersCollection.doc(idDocument).delete();
  }
}
