import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/cloud_constants.dart';
import 'package:harry_potter_app/data/network/api/spell_service.dart';
import 'package:harry_potter_app/domain/model/spell.dart';

class SpellRepository {
  final api = SpellService();
  final spellsCollection = FirebaseFirestore.instance.collection('spells');

  static final SpellRepository _shared = SpellRepository._sharedInstance();
  SpellRepository._sharedInstance(); // Private constructor
  factory SpellRepository() => _shared;

  Future<List<Spell>> loadSpellsFromApi() async {
    final spells = await getSpellsFromCloudFirebase();

    if (spells.isEmpty) {
      insertSpells();
      return getSpellsFromCloudFirebase();
    } else {
      // deleteSpells();
      // insertSpells();
      return spells;
    }
  }

  Future<List<Spell>> getSpellsFromCloudFirebase() async {
    final snapshot = await spellsCollection.get();
    if (snapshot.docs.length >= 2) {
      return snapshot.docs.map((doc) => Spell.fromDocument(doc)).toList();
    } else {
      return [];
    }
  }

  Future<void> insertSpells() async {
    final spellsResponse = await api.getSpells();
    final spells = spellsResponse!
        .map((spellResponse) => Spell.fromResponse(spellResponse))
        .toList();
    final batch = FirebaseFirestore.instance.batch();

    for (var spell in spells) {
      final spellRef = spellsCollection.doc();
      batch.set(
        spellRef,
        spell.toMap(),
      );
    }

    await batch.commit();
    deleteDefaultEmptyDocument();
  }

  Future<void> deleteSpells() async {
    final snapshot = await spellsCollection.get();
    final batch = FirebaseFirestore.instance.batch();

    for (var doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  Future<List<Spell>> searchSpellsByName(String searchQuery) async {
    return await spellsCollection
        .where(nameFieldName, isGreaterThanOrEqualTo: searchQuery.toLowerCase())
        .where(nameFieldName,
            isLessThanOrEqualTo: '${searchQuery.toLowerCase()}\uf8ff')
        .get()
        .then((snapshot) =>
            snapshot.docs.map((doc) => Spell.fromDocument(doc)).toList());
  }

  Future<void> updateSpells(Spell spell) async {
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

  List<Spell> sortSpellsByNameAsc(List<Spell> spells) {
    spells.sort(
        (oneSpell, anotherSpell) => oneSpell.name.compareTo(anotherSpell.name));
    return spells;
  }

  List<Spell> sortSpellsByNameDesc(List<Spell> spells) {
    spells.sort(
        (oneSpell, anotherSpell) => anotherSpell.name.compareTo(oneSpell.name));
    return spells;
  }

  void deleteDefaultEmptyDocument() async {
    final snapshot = await spellsCollection.get();

    for (var doc in snapshot.docs) {
      final data = doc.data();

      if (data.isEmpty) {
        await doc.reference.delete();
      }
    }
  }
}
