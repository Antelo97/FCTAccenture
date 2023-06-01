import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/cloud_constants.dart';
import 'package:harry_potter_app/data/network/api/character_service.dart';
import 'package:harry_potter_app/domain/model/character.dart';

class CharacterRepository {
  final api = CharacterService();
  final charactersCollection =
      FirebaseFirestore.instance.collection('characters');

  static final CharacterRepository _shared =
      CharacterRepository._sharedInstance();
  CharacterRepository._sharedInstance(); // Private constructor
  factory CharacterRepository() => _shared;

  Future<List<Character>> loadCharactersFromApi() async {
    final characters = await getCharactersFromCloudFirebase();

    if (characters.isEmpty) {
      insertCharacters();
      return getCharactersFromCloudFirebase();
    } else {
      // deleteCharacters();
      // insertCharacters();
      return characters;
    }
  }

  Future<List<Character>> getCharactersFromCloudFirebase() async {
    final snapshot = await charactersCollection.get();
    if (snapshot.docs.length >= 2) {
      return snapshot.docs.map((doc) => Character.fromDocument(doc)).toList();
    } else {
      return [];
    }
  }

  Future<void> insertCharacters() async {
    final charactersResponse = await api.getCharacters();
    final characters = charactersResponse!
        .map((characterResponse) => Character.fromResponse(characterResponse))
        .toList();
    final batch = FirebaseFirestore.instance.batch();

    for (var character in characters) {
      final idDoc = charactersCollection.doc();
      batch.set(
        idDoc,
        character.toMap(),
      );
    }

    await batch.commit();
    deleteDefaultEmptyDocument();
  }

  Future<void> deleteCharacters() async {
    final snapshot = await charactersCollection.get();
    final batch = FirebaseFirestore.instance.batch();

    for (var doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  Future<List<Character>> searchCharactersByName(String searchQuery) async {
    return await charactersCollection
        .where(nameFieldName, isGreaterThanOrEqualTo: searchQuery.toLowerCase())
        .where(nameFieldName,
            isLessThanOrEqualTo: '${searchQuery.toLowerCase()}\uf8ff')
        .get()
        .then((snapshot) =>
            snapshot.docs.map((doc) => Character.fromDocument(doc)).toList());
  }

  Future<void> updateCharacter(Character character) async {
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

  List<Character> sortCharactersByNameAsc(List<Character> characters) {
    characters.sort((oneCharacter, anotherCharacter) =>
        oneCharacter.name.compareTo(anotherCharacter.name));
    return characters;
  }

  List<Character> sortCharactersByNameDesc(List<Character> characters) {
    characters.sort((oneCharacter, anotherCharacter) =>
        anotherCharacter.name.compareTo(oneCharacter.name));
    return characters;
  }

  void deleteDefaultEmptyDocument() async {
    final snapshot = await charactersCollection.get();

    for (var doc in snapshot.docs) {
      final data = doc.data();

      if (data.isEmpty) {
        await doc.reference.delete();
      }
    }
  }
}
