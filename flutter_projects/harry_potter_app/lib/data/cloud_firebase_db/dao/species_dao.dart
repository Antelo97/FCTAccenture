import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/cloud_constants.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/model_collection/species_collection.dart';
import 'package:harry_potter_app/data/network/api/species_service.dart';

class SpeciesDao {
  final api = SpeciesService();
  final speciesCollection = FirebaseFirestore.instance.collection('species');

  static final SpeciesDao _shared = SpeciesDao._sharedInstance();
  SpeciesDao._sharedInstance(); // Private constructor
  factory SpeciesDao() => _shared;

  Future<List<SpeciesCollection>> getSpeciesFromApi() async {
    final species = await api.getSpecies();

    if (species!.isNotEmpty) {
      deleteSpecies();
      insertSpecies();
      return species.map((e) => SpeciesCollection.fromResponse(e)).toList();
    } else {
      return getSpeciesFromCloudFirebase();
    }
  }

  Future<List<SpeciesCollection>> getSpeciesFromCloudFirebase() async {
    return await speciesCollection.get().then((snapshot) => snapshot.docs
        .map((doc) => SpeciesCollection.fromSnapshot(doc))
        .toList());
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

  Future<List<SpeciesCollection>> searchSpeciesByName(
      String searchQuery) async {
    return await speciesCollection
        .where(nameFieldName, isGreaterThanOrEqualTo: searchQuery.toLowerCase())
        .where(nameFieldName,
            isLessThanOrEqualTo: '${searchQuery.toLowerCase()}\uf8ff')
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => SpeciesCollection.fromSnapshot(doc))
            .toList());
  }

  Future<void> updateSpecies(SpeciesCollection species) async {
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

  List<SpeciesCollection> sortSpeciesByNameAsc(
      List<SpeciesCollection> species) {
    species.sort((oneSpecies, anotherSpecies) =>
        oneSpecies.name.compareTo(anotherSpecies.name));
    return species;
  }

  List<SpeciesCollection> sortSpeciesByNameDesc(
      List<SpeciesCollection> species) {
    species.sort((oneSpecies, anotherSpecies) =>
        anotherSpecies.name.compareTo(oneSpecies.name));
    return species;
  }
}