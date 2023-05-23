import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/cloud_constants.dart';
import 'package:harry_potter_app/data/network/model_response/character_response.dart';

@immutable
class CharacterCollection {
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

  const CharacterCollection({
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

  CharacterCollection.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : idDocument = snapshot.id,
        idApiCharacter = snapshot.data()[idApiCharacterFieldName] as String,
        name = snapshot.data()[nameFieldName] as String,
        species = snapshot.data()[speciesFieldName] as Species,
        gender = snapshot.data()[genderFieldName] as Gender,
        house = snapshot.data()[houseFieldName] as House,
        yearOfBirth = snapshot.data()[yearOfBirthFieldName] as int?,
        isWizard = snapshot.data()[isWizardFieldName] as bool,
        ancestry = snapshot.data()[ancestryFieldName] as Ancestry,
        wand = snapshot.data()[wandFieldName] as Wand,
        patronus = snapshot.data()[patronusFieldName] as Patronus,
        isHogwartsStudent = snapshot.data()[isHogwartsStudentFieldName] as bool,
        isHogwartsStaff = snapshot.data()[isHogwartsStaffFieldName] as bool,
        actor = snapshot.data()[actorFieldName] as String,
        isAlive = snapshot.data()[isAliveFieldName] as bool,
        imageUrl = snapshot.data()[imageUrlFieldName] as String;
}
