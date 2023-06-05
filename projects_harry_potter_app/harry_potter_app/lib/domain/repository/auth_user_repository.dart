import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/cloud_constants.dart';
import 'package:harry_potter_app/domain/model/auth_user.dart';
import 'package:harry_potter_app/domain/model/book.dart';
import 'package:harry_potter_app/domain/model/character.dart';
import 'package:harry_potter_app/domain/model/species.dart';
import 'package:harry_potter_app/domain/model/spell.dart';
import 'package:harry_potter_app/domain/repository/book_repository.dart';
import 'package:harry_potter_app/domain/repository/character_repository.dart';
import 'package:harry_potter_app/domain/repository/species_repository.dart';
import 'package:harry_potter_app/domain/repository/spell_repository.dart';

class AuthUserRepository {
  final usersCollection = FirebaseFirestore.instance.collection('users');

  static final AuthUserRepository _shared =
      AuthUserRepository._sharedInstance();
  AuthUserRepository._sharedInstance(); // Private constructor
  factory AuthUserRepository() => _shared;

  Future<AuthUser?> getUserFromCloudFirebase(String idFirebase) async {
    final authUser = await usersCollection
        .where(
          idFirebaseFieldName,
          isEqualTo: idFirebase,
        )
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

  // Future<void> updateIsEmailVerified(AuthUser user) async {
  //   final document = await usersCollection.doc(user.idDocument).get();
  //   if (document.exists) {
  //     if (document.data()![isEmailVerifiedFieldName] != user.isEmailVerified) {
  //       await usersCollection.doc(user.idDocument).update({
  //         isEmailVerifiedFieldName: user.isEmailVerified,
  //       });
  //     }
  //   }
  // }

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

  Future<List<AuthUser?>> getUsersFromCloudFirebase() async {
    final authUser = await usersCollection.get().then((snapshot) =>
        snapshot.docs.map((doc) => AuthUser.fromDocument(doc)).toList());
    return authUser;
  }

  Future<Map<Book, int>> getFeaturedBooks() async {
    Map<Book, int> featuredBooks = <Book, int>{};
    int counts = 0;
    final books = await BookRepository().getBooksFromCloudFirebase();
    final authUsers = await getUsersFromCloudFirebase();

    for (var book in books) {
      for (var authUser in authUsers) {
        if (authUser != null && authUser.favoriteBooks.contains(book)) {
          counts++;
        }
      }
      featuredBooks[book] = counts;
      counts = 0;
    }

    List<MapEntry<Book, int>> sortedEntries = featuredBooks.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    Map<Book, int> sortedFeaturedBooks = Map.fromEntries(sortedEntries);

    return sortedFeaturedBooks;
  }

  Future<Map<Character, int>> getFeaturedCharacters() async {
    Map<Character, int> featuredCharacters = <Character, int>{};
    int counts = 0;
    final characters =
        await CharacterRepository().getCharactersFromCloudFirebase();
    final authUsers = await getUsersFromCloudFirebase();

    for (var character in characters) {
      for (var authUser in authUsers) {
        if (authUser != null &&
            authUser.favoriteCharacters.contains(character)) {
          counts++;
        }
      }
      featuredCharacters[character] = counts;
      counts = 0;
    }

    List<MapEntry<Character, int>> sortedEntries = featuredCharacters.entries
        .toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    Map<Character, int> sortedFeaturedCharacters =
        Map.fromEntries(sortedEntries);

    return sortedFeaturedCharacters;
  }

  Future<Map<Spell, int>> getFeaturedSpells() async {
    Map<Spell, int> featuredSpells = <Spell, int>{};
    int counts = 0;
    final spells = await SpellRepository().getSpellsFromCloudFirebase();
    final authUsers = await getUsersFromCloudFirebase();

    for (var spell in spells) {
      for (var authUser in authUsers) {
        if (authUser != null && authUser.favoriteSpells.contains(spell)) {
          counts++;
        }
      }
      featuredSpells[spell] = counts;
      counts = 0;
    }

    List<MapEntry<Spell, int>> sortedEntries = featuredSpells.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    Map<Spell, int> sortedFeaturedSpells = Map.fromEntries(sortedEntries);

    return sortedFeaturedSpells;
  }

  Future<Map<Species, int>> getFeaturedSpeciess() async {
    Map<Species, int> featuredSpecies = <Species, int>{};
    int counts = 0;
    final species = await SpeciesRepository().getSpeciesFromCloudFirebase();
    final authUsers = await getUsersFromCloudFirebase();

    for (var speciesItem in species) {
      for (var authUser in authUsers) {
        if (authUser != null &&
            authUser.favoriteSpecies.contains(speciesItem)) {
          counts++;
        }
      }
      featuredSpecies[speciesItem] = counts;
      counts = 0;
    }

    List<MapEntry<Species, int>> sortedEntries = featuredSpecies.entries
        .toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    Map<Species, int> sortedFeaturedSpecies = Map.fromEntries(sortedEntries);

    return sortedFeaturedSpecies;
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
