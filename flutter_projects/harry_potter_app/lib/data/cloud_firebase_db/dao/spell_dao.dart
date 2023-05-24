import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/cloud_constants.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/model_collection/spell_collection.dart';
import 'package:harry_potter_app/data/network/api/spell_service.dart';

class SpellDao {
  final api = SpellService();
  final spellsCollection = FirebaseFirestore.instance.collection('spells');

  static final SpellDao _shared = SpellDao._sharedInstance();
  SpellDao._sharedInstance(); // Private constructor
  factory SpellDao() => _shared;

  Future<List<SpellCollection>> getSpellsFromApi() async {
    final spells = await api.getSpells();

    if (spells!.isNotEmpty) {
      deleteSpells();
      insertSpells();
      return spells.map((e) => SpellCollection.fromResponse(e)).toList();
    } else {
      return getSpellsFromCloudFirebase();
    }
  }

  Future<List<SpellCollection>> getSpellsFromCloudFirebase() async {
    return await spellsCollection.get().then((snapshot) =>
        snapshot.docs.map((doc) => SpellCollection.fromSnapshot(doc)).toList());
  }

  Future<void> insertSpells() async {
    final spells = await api.getSpells();
    final batch = FirebaseFirestore.instance.batch();

    for (var spell in spells!) {
      final spellRef = FirebaseFirestore.instance.collection('spells').doc();
      batch.set(spellRef, spell.toJson());
    }

    await batch.commit();
  }

  Future<void> deleteSpells() async {
    final snapshot = await spellsCollection.get();
    final batch = FirebaseFirestore.instance.batch();

    for (var doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  Future<List<SpellCollection>> searchSpellsByName(String searchQuery) async {
    return await spellsCollection
        .where(nameFieldName, isGreaterThanOrEqualTo: searchQuery.toLowerCase())
        .where(nameFieldName,
            isLessThanOrEqualTo: '${searchQuery.toLowerCase()}\uf8ff')
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => SpellCollection.fromSnapshot(doc))
            .toList());
  }

  Future<void> updateSpells(SpellCollection spell) async {
    try {
      await spellsCollection.doc(spell.idDocument).update({
        idApiSpellFieldName: spell.idApiSpell,
        nameFieldName: spell.name,
        descriptionFieldName: spell.description,
        imageUrlFieldName: spell.imageUrl,
      });
    } catch (e) {
      // CouldNotUpdateNoteException();
    }
  }

  List<SpellCollection> sortSpellsByNameAsc(List<SpellCollection> spells) {
    spells.sort(
        (oneSpell, anotherSpell) => oneSpell.name.compareTo(anotherSpell.name));
    return spells;
  }

  List<SpellCollection> sortSpellsByNameDesc(List<SpellCollection> spells) {
    spells.sort(
        (oneSpell, anotherSpell) => anotherSpell.name.compareTo(oneSpell.name));
    return spells;
  }
}
