import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/cloud_constants.dart';
import 'package:harry_potter_app/data/network/model_response/character_response.dart';

@immutable
class Character {
  final String idDocument;
  final String idApiCharacter;
  final String name;
  final Species species;
  final Gender gender;
  final House house;
  final int? yearOfBirth;
  final bool isWizard;
  final Ancestry ancestry;
  final Wand wand;
  final Patronus patronus;
  final bool isHogwartsStudent;
  final bool isHogwartsStaff;
  final String actor;
  final bool isAlive;
  final String imageUrl;

  const Character({
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
        species = document.data()[speciesFieldName] as Species,
        gender = document.data()[genderFieldName] as Gender,
        house = document.data()[houseFieldName] as House,
        yearOfBirth = document.data()[yearOfBirthFieldName] as int?,
        isWizard = document.data()[isWizardFieldName] as bool,
        ancestry = document.data()[ancestryFieldName] as Ancestry,
        wand = document.data()[wandFieldName] as Wand,
        patronus = document.data()[patronusFieldName] as Patronus,
        isHogwartsStudent = document.data()[isHogwartsStudentFieldName] as bool,
        isHogwartsStaff = document.data()[isHogwartsStaffFieldName] as bool,
        actor = document.data()[actorFieldName] as String,
        isAlive = document.data()[isAliveFieldName] as bool,
        imageUrl = document.data()[imageUrlFieldName] as String;

  Character.fromResponse(CharacterResponse character)
      : idDocument = '',
        idApiCharacter = character.idApi,
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
}

String getImageUrl(String imageUrl) {
  if (imageUrl == "") {
    return "https://objetivoligar.com/wp-content/uploads/2017/03/blank-profile-picture-973460_1280.jpg";
  } else {
    return imageUrl;
  }
}
