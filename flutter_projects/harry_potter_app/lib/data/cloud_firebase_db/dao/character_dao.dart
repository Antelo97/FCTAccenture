import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/cloud_constants.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/model_collection/character_collection.dart';
import 'package:harry_potter_app/data/network/api/character_service.dart';

class CharacterDao {
  final api = CharacterService();
  final charactersCollection =
      FirebaseFirestore.instance.collection('characters');

  static final CharacterDao _shared = CharacterDao._sharedInstance();
  CharacterDao._sharedInstance(); // Private constructor
  factory CharacterDao() => _shared;

  Future<List<CharacterCollection>> getCharactersFromApi() async {
    final characters = await api.getCharacters();

    if (characters!.isNotEmpty) {
      deleteCharacters();
      insertCharacters();
      return characters
          .map((e) => CharacterCollection.fromResponse(e))
          .toList();
    } else {
      return getCharactersFromCloudFirebase();
    }
  }

  Future<List<CharacterCollection>> getCharactersFromCloudFirebase() async {
    return await charactersCollection.get().then((snapshot) => snapshot.docs
        .map((doc) => CharacterCollection.fromSnapshot(doc))
        .toList());
  }

  Future<void> insertCharacters() async {
    final characters = await api.getCharacters();
    final batch = FirebaseFirestore.instance.batch();

    for (var character in characters!) {
      final characterRef =
          FirebaseFirestore.instance.collection('characters').doc();
      batch.set(characterRef, character.toJson());
    }

    await batch.commit();
  }

  Future<void> deleteCharacters() async {
    final snapshot = await charactersCollection.get();
    final batch = FirebaseFirestore.instance.batch();

    for (var doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  Future<List<CharacterCollection>> searchCharactersByName(
      String searchQuery) async {
    return await charactersCollection
        .where(nameFieldName, isGreaterThanOrEqualTo: searchQuery.toLowerCase())
        .where(nameFieldName,
            isLessThanOrEqualTo: '${searchQuery.toLowerCase()}\uf8ff')
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => CharacterCollection.fromSnapshot(doc))
            .toList());
  }

  Future<void> updateCharacter(CharacterCollection character) async {
    try {
      await charactersCollection.doc(character.idDocument).update({
        idApiCharacterFieldName: character.idApiCharacter,
        nameFieldName: character.name,
        speciesFieldName: character.species,
        genderFieldName: character.gender,
        houseFieldName: character.house,
        yearOfBirthFieldName: character.yearOfBirth,
        isWizardFieldName: character.isWizard,
        ancestryFieldName: character.ancestry,
        wandFieldName: character.wand,
        patronusFieldName: character.patronus,
        isHogwartsStudentFieldName: character.isHogwartsStudent,
        isHogwartsStaffFieldName: character.isHogwartsStaff,
        actorFieldName: character.actor,
        isAliveFieldName: character.isAlive,
        imageUrlFieldName: character.imageUrl,
      });
    } catch (e) {
      // CouldNotUpdateNoteException();
    }
  }

  List<CharacterCollection> sortCharactersByNameAsc(
      List<CharacterCollection> characters) {
    characters.sort((oneCharacter, anotherCharacter) =>
        oneCharacter.name.compareTo(anotherCharacter.name));
    return characters;
  }

  List<CharacterCollection> sortCharactersByNameDesc(
      List<CharacterCollection> characters) {
    characters.sort((oneCharacter, anotherCharacter) =>
        anotherCharacter.name.compareTo(oneCharacter.name));
    return characters;
  }
}