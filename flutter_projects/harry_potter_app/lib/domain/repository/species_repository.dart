import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/cloud_constants.dart';
import 'package:harry_potter_app/data/network/api/species_service.dart';
import 'package:harry_potter_app/domain/model/species.dart';

class SpeciesRepository {
  final api = SpeciesService();
  final speciesCollection = FirebaseFirestore.instance.collection('species');

  static final SpeciesRepository _shared = SpeciesRepository._sharedInstance();
  SpeciesRepository._sharedInstance(); // Private constructor
  factory SpeciesRepository() => _shared;

  Future<List<Species>> loadSpeciesFromApi() async {
    final species = await getSpeciesFromCloudFirebase();

    if (species.isEmpty) {
      insertSpecies();
      return getSpeciesFromCloudFirebase();
    } else {
      // deleteSpecies();
      // insertSpecies();
      return species;
    }
  }

  Future<List<Species>> getSpeciesFromCloudFirebase() async {
    return await speciesCollection.get().then((snapshot) =>
        snapshot.docs.map((doc) => Species.fromDocument(doc)).toList());
  }

  Future<void> insertSpecies() async {
    final speciesList = await api.getSpecies();
    final batch = FirebaseFirestore.instance.batch();

    for (var species in speciesList!) {
      final speciesRef = FirebaseFirestore.instance.collection('species').doc();
      batch.set(speciesRef, species.toJson());
    }

    await batch.commit();
  }

  Future<void> deleteSpecies() async {
    final snapshot = await speciesCollection.get();
    final batch = FirebaseFirestore.instance.batch();

    for (var doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  Future<List<Species>> searchSpeciesByName(String searchQuery) async {
    return await speciesCollection
        .where(nameFieldName, isGreaterThanOrEqualTo: searchQuery.toLowerCase())
        .where(nameFieldName,
            isLessThanOrEqualTo: '${searchQuery.toLowerCase()}\uf8ff')
        .get()
        .then((snapshot) =>
            snapshot.docs.map((doc) => Species.fromDocument(doc)).toList());
  }

  Future<void> updateSpecies(Species species) async {
    try {
      await speciesCollection.doc(species.idDocument).update({
        idApiSpeciesFieldName: species.idApiSpecies,
        nameFieldName: species.name,
        nativeFieldName: species.native,
        imageUrlFieldName: species.imageUrl,
      });
    } catch (e) {
      // CouldNotUpdateNoteException();
    }
  }

  List<Species> sortSpeciesByNameAsc(List<Species> species) {
    species.sort((oneSpecies, anotherSpecies) =>
        oneSpecies.name.compareTo(anotherSpecies.name));
    return species;
  }

  List<Species> sortSpeciesByNameDesc(List<Species> species) {
    species.sort((oneSpecies, anotherSpecies) =>
        anotherSpecies.name.compareTo(oneSpecies.name));
    return species;
  }
}
