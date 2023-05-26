import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/cloud_constants.dart';
import 'package:harry_potter_app/data/network/model_response/spell_response.dart';

@immutable
class SpellCollection {
  final String idDocument;
  final String idApiSpell;
  final String name;
  final String description;
  final String imageUrl;

  const SpellCollection({
    required this.idDocument,
    required this.idApiSpell,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  SpellCollection.fromDocument(
      QueryDocumentSnapshot<Map<String, dynamic>> document)
      : idDocument = document.id,
        idApiSpell = document.data()[idApiSpellFieldName] as String,
        name = document.data()[nameFieldName] as String,
        description = document.data()[descriptionFieldName] as String,
        imageUrl = document.data()[imageUrlFieldName] as String;

  SpellCollection.fromResponse(SpellResponse spell)
      : idDocument = '',
        idApiSpell = spell.idApi,
        name = spell.name,
        description = spell.description,
        imageUrl = getImageUrl(spell.name);
}

String getImageUrl(String spellName) {
  switch (spellName) {
    case "Aberto":
      return "https://pm1.narvii.com/6362/2dbe049f4a002eaf6608d75a37362aabe2a4ff23_128.jpg";
    case "Accio":
      return "https://es.web.img3.acsta.net/r_1280_720/newsv7/22/02/02/12/06/4644697.jpg";
    case "Aguamenti":
      return "https://static.wikia.nocookie.net/esharrypotter/images/1/1a/HM_Aguamenti.png/revision/latest?cb=20201015215819";
    case "Alohomora":
      return "https://static.wikia.nocookie.net/esharrypotter/images/9/9e/HM_Alohomora.png/revision/latest?cb=20210130191700";
    case "Anapneo":
      return "https://pm1.narvii.com/6283/86c9cc419f387b91cfca9cd2eec4e2cb0f15c0e5_00.jpg";
    case "Aparecium":
      return "https://static.wikia.nocookie.net/esharrypotter/images/0/02/Aparecium.jpg/revision/latest?cb=20141018154850";
    case "Apparate":
      return "https://static.wikia.nocookie.net/harrypotter/images/b/be/Dumbledore_and_Harry_performing_Apparition.gif/revision/latest?cb=20110819093308";
    case "Ascendio":
      return "https://static.wikia.nocookie.net/esharrypotter/images/8/8a/HM_Ascendio.png/revision/latest?cb=20210131005332";
    case "Avada Kedavra":
      return "https://static.wikia.nocookie.net/esharrypotter/images/a/ac/P8_Avada_Kedavra.gif/revision/latest?cb=20180507171744";
    case "Avis":
      return "https://static.wikia.nocookie.net/esharrypotter/images/1/15/HM_Avis.png/revision/latest?cb=20210129102637";
    case "Bat":
      return "https://static.wikia.nocookie.net/harrypotter/images/c/cd/Bat-Bogey_Hex_HM.png/revision/latest?cb=20210131145234";
    case "Bombardo":
      return "https://static.wikia.nocookie.net/esharrypotter/images/1/16/Bombarda_%28Hogarts_Mystery%29.png/revision/latest?cb=20180817035143";
    case "Brackium Emendo":
      return "https://static.wikia.nocookie.net/esharrypotter/images/2/27/Braquiam_Emendo.jpg/revision/latest?cb=20140728150216";
    case "Capacious Extremis":
      return "https://pa1.narvii.com/6872/028cf61d8fb4e5b0da2cdf0986308f05320efcf8r1-537-274_00.gif";
    case "Confundo":
      return "https://static.wikia.nocookie.net/esharrypotter/images/1/1d/HM_Confundus.png/revision/latest?cb=20210130233227";
    case "Conjunctivitis Curse":
      return "https://static.wikia.nocookie.net/harrypotter/images/7/78/Conjunctivitis_Curse.gif/revision/latest?cb=20220828005820";
    case "Crinus Muto":
      return "https://static.wikia.nocookie.net/esharrypotter/images/9/92/Crinus_Muto.png/revision/latest?cb=20170213044446";
    case "Crucio":
      return "https://static.wikia.nocookie.net/esharrypotter/images/9/9c/Voldemort_crucio_harry.gif/revision/latest?cb=20180507171146";
    case "Diffindo":
      return "https://static.wikia.nocookie.net/esharrypotter/images/5/5d/Diffindo_%28Hogwarts_Mystery%29.png/revision/latest?cb=20180817035147";
    case "Disillusionment Charm":
      return "https://static.wikia.nocookie.net/harrypotter/images/b/b7/DisillusionmentCharmHM.png/revision/latest?cb=20201214080033";
    case "Disapparate":
      return "https://qph.cf2.quoracdn.net/main-qimg-f62daf6b0472b939cf4536dc541a472b-pjlq";
    case "Engorgio":
      return "https://static.wikia.nocookie.net/esharrypotter/images/a/ac/HM_Engorgio.png/revision/latest?cb=20210130200225";
    case "Episkey":
      return "https://static.wikia.nocookie.net/esharrypotter/images/0/09/HM_Episkey.png/revision/latest?cb=20210130201712";
    case "Expecto patronum":
      return "https://static.wikia.nocookie.net/esharrypotter/images/6/6e/PM_Patronusciervo.jpg/revision/latest/scale-to-width-down/700?cb=20170203154413";
    case "Erecto":
      return "https://static.wikia.nocookie.net/harrypotterfannon/images/5/5f/Erecto.gif/revision/latest?cb=20130813234321&path-prefix=es";
    case "Evanesco":
      return "https://static.wikia.nocookie.net/esharrypotter/images/7/76/Evanesco_%28Hogwarts_Mystery%29.png/revision/latest?cb=20180817035148";
    case "Expelliarmus":
      return "https://static.wikia.nocookie.net/esharrypotter/images/6/63/HM_Expelliarmus.png/revision/latest?cb=20210130190717";
    case "Ferula":
      return "https://static.wikia.nocookie.net/esharrypotter/images/8/89/HM_F%C3%A9rula.png/revision/latest?cb=20201125223641";
    case "Fidelius Charm":
      return "https://static.wikia.nocookie.net/harrypotter/images/0/0f/Harry-potter1-voldemort_cottage.jpg/revision/latest/scale-to-width-down/1000?cb=20170730194346";
    case "Fiendfyre Curse":
      return "https://static.wikia.nocookie.net/harrypotter/images/1/18/Harry_and_Draco.png/revision/latest/scale-to-width-down/1000?cb=20170204081554";
    case "Finite Incantatem":
      return "https://static.wikia.nocookie.net/esharrypotter/images/1/15/HM_Finite_Incantatem.png/revision/latest?cb=20210130210350";
    case "Furnunculus Curse":
      return "https://static.wikia.nocookie.net/harrypotter/images/f/f4/Furnunculus.png/revision/latest?cb=20140116223259";
    case "Geminio":
      return "https://static.wikia.nocookie.net/esharrypotter/images/4/4b/Geminio.gif/revision/latest?cb=20170209035723";
    case "Glisseo":
      return "https://pm1.narvii.com/7014/2aa923393955d27ff0ae85ad2499c2779912a6dcr1-545-307v2_uhq.jpg";
    case "Homenum Revelio":
      return "https://static.wikia.nocookie.net/esharrypotter/images/8/84/HM_Homenum_Revelio.png/revision/latest?cb=20210130061430";
    case "Homonculus Charm":
      return "https://static.wikia.nocookie.net/esharrypotter/images/2/27/Encantamiento_Homonculous.gif/revision/latest?cb=20180723173522";
    case "Immobulus":
      return "https://static.wikia.nocookie.net/esharrypotter/images/0/0b/HM_Immobulus.png/revision/latest?cb=20210130211935";
    case "Impedimenta":
      return "https://static.wikia.nocookie.net/esharrypotter/images/9/95/HM_Impedimenta.png/revision/latest?cb=20210130050626";
    case "Incarcerous":
      return "https://static.wikia.nocookie.net/esharrypotter/images/7/7b/HM_Incarcerous.png/revision/latest?cb=20210129094204";
    case "Imperio":
      return "https://static.wikia.nocookie.net/harrypotterfannon/images/c/c5/Imperio.gif/revision/latest?cb=20220919234212&path-prefix=es";
    case "Impervius":
      return "https://static.wikia.nocookie.net/esharrypotter/images/9/91/HM_Impervius.png/revision/latest?cb=20220721212355";
    case "Incendio":
      return "https://static.wikia.nocookie.net/esharrypotter/images/2/2e/HM_Incendio.png/revision/latest?cb=20210130200939";
    case "Langlock":
      return "https://static.wikia.nocookie.net/esharrypotter/images/7/75/HM_Palalingua.png/revision/latest?cb=20200217221456";
    case "Legilimens":
      return "https://media.harrypotterfanzone.com/snape-uses-legilimens.gif";
    case "Levicorpus":
      return "https://static.wikia.nocookie.net/esharrypotter/images/e/e3/HM_Levicorpus.png/revision/latest?cb=20210130065935";
    case "Locomotor Mortis":
      return "https://static.wikia.nocookie.net/esharrypotter/images/c/c5/HM_Locomotor_Mortis.png/revision/latest?cb=20210130225329";
    case "Lumos":
      return "https://static.wikia.nocookie.net/esharrypotter/images/c/ca/HM_Lumos.png/revision/latest?cb=20211021004314";
    case "Morsmordre":
      return "https://static.wikia.nocookie.net/esharrypotter/images/a/af/P6_Marca_Tenebrosa.jpg/revision/latest?cb=20111207225635";
    case "Mucus Ad Nauseam":
      return "https://static.wikia.nocookie.net/esharrypotter/images/9/9b/HM_Maleficio_de_los_mocos.png/revision/latest?cb=20210130055235";
    case "Muffliato":
      return "https://static.wikia.nocookie.net/esharrypotter/images/b/ba/HM_Muffliato.png/revision/latest?cb=20210130232037";
    case "Nox":
      return "https://static.wikia.nocookie.net/esharrypotter/images/d/de/HM_Nox.png/revision/latest?cb=20210130192945";
    case "Obliviate":
      return "https://static.wikia.nocookie.net/esharrypotter/images/5/5d/Obliviate.JPG/revision/latest/scale-to-width-down/700?cb=20111005194114";
    case "Obscuro":
      return "https://static.wikia.nocookie.net/esharrypotter/images/4/4c/HM_Obscuro.png/revision/latest?cb=20210131111649";
    case "Oculus Reparo":
      return "https://static.wikia.nocookie.net/esharrypotter/images/5/51/P1_Oculus_reparo.jpg/revision/latest?cb=20140315223043";
    case "Oppugno":
      return "https://static.wikia.nocookie.net/esharrypotter/images/1/10/20110819-js-hpdhp1-oppugno.gif/revision/latest?cb=20111209165538";
    case "Petrificus Totalus":
      return "https://static.wikia.nocookie.net/esharrypotter/images/6/61/HM_Petrificus_Totalus.png/revision/latest?cb=20210130210820";
    case "Periculum":
      return "https://static.wikia.nocookie.net/esharrypotter/images/8/83/P4_Chispas_rojas.gif/revision/latest?cb=20180505231232";
    case "Piertotum Locomotor":
      return "https://static.wikia.nocookie.net/esharrypotter/images/3/3d/P8_Piertotum_locomotor.gif/revision/latest?cb=20180507174110";
    case "Protean Charm":
      return "https://static.wikia.nocookie.net/harrypotter/images/c/cf/EnchantedCoin.png/revision/latest?cb=20151226020949";
    case "Protego":
      return "https://harrypotter.fandom.com/es/wiki/Encantamiento_escudo?file=HM_Protego.png";
    case "Reducto":
      return "https://static.wikia.nocookie.net/esharrypotter/images/2/24/HM_Maldici%C3%B3n_Reductora.png/revision/latest?cb=20210130060225";
    case "Reducio":
      return "https://static.wikia.nocookie.net/esharrypotter/images/d/dc/HM_Reducio.png/revision/latest?cb=20210130202206";
    case "Renneverate":
      return "https://static.wikia.nocookie.net/harrypotter/images/8/8c/Revive_Charm_WU.png/revision/latest?cb=20200922110932";
    case "Reparifors":
      return "https://static.wikia.nocookie.net/harrypotter/images/a/a2/HM_y2_Reparifarge.png/revision/latest?cb=20180602223725";
    case "Reparo":
      return "https://static.wikia.nocookie.net/esharrypotter/images/a/a7/HM_Reparo.png/revision/latest?cb=20210129084734";
    case "Rictusempra":
      return "https://static.wikia.nocookie.net/esharrypotter/images/6/6f/HM_Rictusempra.png/revision/latest?cb=20210130191056";
    case "Riddikulus":
      return "https://static.wikia.nocookie.net/esharrypotter/images/f/fa/Riddikulus.gif/revision/latest?cb=20180729232323";
    case "Scourgify":
      return "https://static.wikia.nocookie.net/harrypotterfannon/images/f/f5/Fregotego_ficha.png/revision/latest?cb=20220410234518&path-prefix=es";
    case "Sectumsempra":
      return "https://static.wikia.nocookie.net/esharrypotter/images/3/3a/Sectumempra_Curse.gif/revision/latest?cb=20180507171745";
    case "Serpensortia":
      return "https://static.wikia.nocookie.net/esharrypotter/images/2/2b/HM_Serpensortia.png/revision/latest?cb=20210129092905";
    case "Silencio":
      return "https://static.wikia.nocookie.net/esharrypotter/images/0/0d/HM_Silencio.png/revision/latest?cb=20210130224415";
    case "Sonorus":
      return "https://static.wikia.nocookie.net/harrypotterfannon/images/a/a7/Sonorous.jpg/revision/latest/scale-to-width-down/249?cb=20130902001614&path-prefix=es";
    case "Spongify":
      return "https://static.wikia.nocookie.net/esharrypotter/images/c/c1/HM_Spongify.png/revision/latest?cb=20210129085046";
    case "Stupefy":
      return "https://static.wikia.nocookie.net/esharrypotter/images/5/55/HM_Desmaius.png/revision/latest?cb=20210130051354";
    case "Tarantallegra":
      return "https://static.wikia.nocookie.net/esharrypotter/images/0/0e/HM_Tarantallegra.png/revision/latest?cb=20230224005606";
    case "Unbreakable Vow":
      return "https://static.wikia.nocookie.net/harrypotter/images/2/2c/Unbreakable_Vow.jpg/revision/latest/scale-to-width-down/700?cb=20090523234232";
    case "Wingardium Leviosa":
      return "https://static.wikia.nocookie.net/esharrypotter/images/0/0e/HM_Wingardium_Leviosa.png/revision/latest?cb=20210130191416";
    default:
      return "https://cdn.hobbyconsolas.com/sites/navi.axelspringer.es/public/styles/1200/public/media/image/2019/09/expelliarmus-harry-potter.jpg?itok=4Z_55qWw";
  }
}
