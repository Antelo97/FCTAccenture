import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/cloud_constants.dart';
import 'package:harry_potter_app/data/network/model_response/character_response.dart';

class Character {
  String? idDocument;
  final String idApiCharacter;
  final String name;
  final String species;
  final String gender;
  final String house;
  final int? yearOfBirth;
  final bool isWizard;
  final String ancestry;
  final Wand wand;
  final String patronus;
  final bool isHogwartsStudent;
  final bool isHogwartsStaff;
  final String actor;
  final bool isAlive;
  final String imageUrl;

  Character({
    required this.idDocument,
    required this.idApiCharacter,
    required this.name,
    required this.species,
    required this.gender,
    required this.house,
    required this.yearOfBirth,
    required this.isWizard,
    required this.ancestry,
    required this.wand,
    required this.patronus,
    required this.isHogwartsStudent,
    required this.isHogwartsStaff,
    required this.actor,
    required this.isAlive,
    required this.imageUrl,
  });

  Character.fromDocument(QueryDocumentSnapshot<Map<String, dynamic>> document)
      : idDocument = document.id,
        idApiCharacter = document.data()[idApiCharacterFieldName] as String,
        name = document.data()[nameFieldName] as String,
        species = document.data()[speciesFieldName] as String,
        gender = document.data()[genderFieldName] as String,
        house = document.data()[houseFieldName] as String,
        yearOfBirth = document.data()[yearOfBirthFieldName] as int?,
        isWizard = document.data()[isWizardFieldName] as bool,
        ancestry = document.data()[ancestryFieldName] as String,
        wand = _convertToWand(
            document.data()[wandFieldName] as Map<String, dynamic>),
        patronus = document.data()[patronusFieldName] as String,
        isHogwartsStudent = document.data()[isHogwartsStudentFieldName] as bool,
        isHogwartsStaff = document.data()[isHogwartsStaffFieldName] as bool,
        actor = document.data()[actorFieldName] as String,
        isAlive = document.data()[isAliveFieldName] as bool,
        imageUrl = document.data()[imageUrlFieldName] as String;

  Character.fromResponse(CharacterResponse character)
      : idApiCharacter = character.idApi,
        name = character.name,
        species = character.species,
        gender = character.gender,
        house = character.house,
        yearOfBirth = character.yearOfBirth,
        isWizard = character.isWizard,
        ancestry = character.ancestry,
        wand = character.wand,
        patronus = character.patronus,
        isHogwartsStudent = character.isHogwartsStudent,
        isHogwartsStaff = character.isHogwartsStaff,
        actor = character.actor,
        isAlive = character.isAlive,
        imageUrl = getImageUrl(character.imageUrl);

  Character.fromMap(Map<String, dynamic> map)
      : idApiCharacter = map[idApiCharacterFieldName] as String,
        name = map[nameFieldName] as String,
        species = map[speciesFieldName] as String,
        gender = map[genderFieldName] as String,
        house = map[houseFieldName] as String,
        yearOfBirth = map[yearOfBirthFieldName] as int,
        isWizard = map[isWizardFieldName] as bool,
        ancestry = map[ancestryFieldName] as String,
        wand = map[wandFieldName] as Wand,
        patronus = map[patronusFieldName] as String,
        isHogwartsStudent = map[isHogwartsStudentFieldName] as bool,
        isHogwartsStaff = map[isHogwartsStaffFieldName] as bool,
        actor = map[actorFieldName] as String,
        isAlive = map[isAliveFieldName] as bool,
        imageUrl = map[imageUrlFieldName] as String;

  Map<String, dynamic> toMap() {
    return {
      idApiCharacterFieldName: idApiCharacter,
      nameFieldName: name,
      speciesFieldName: species,
      genderFieldName: gender,
      houseFieldName: house,
      yearOfBirthFieldName: yearOfBirth,
      isWizardFieldName: isWizard,
      ancestryFieldName: ancestry,
      wandFieldName: wand.toJson(),
      patronusFieldName: patronus,
      isHogwartsStudentFieldName: isHogwartsStudent,
      isHogwartsStaffFieldName: isHogwartsStaff,
      actorFieldName: actor,
      isAliveFieldName: isAlive,
      imageUrlFieldName: imageUrl,
    };
  }
}

Wand _convertToWand(Map<String, dynamic> wand) {
  return Wand.fromJson(wand);
}

String getImageUrl(String imageUrl) {
  if (imageUrl == "") {
    return "https://objetivoligar.com/wp-content/uploads/2017/03/blank-profile-picture-973460_1280.jpg";
  } else {
    return imageUrl;
  }
}
