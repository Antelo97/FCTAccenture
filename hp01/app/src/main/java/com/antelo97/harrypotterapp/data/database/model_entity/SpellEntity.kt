package com.antelo97.harrypotterapp.data.database.model_entity

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey
import com.antelo97.harrypotterapp.data.network.model_response.SpellResponse
import com.antelo97.harrypotterapp.domain.model.Spell

@Entity(tableName = "Spells")
data class SpellEntity(
    @PrimaryKey(autoGenerate = false)
    @ColumnInfo(name = "id_api_spell") val idApiSpell: String,
    @ColumnInfo(name = "name") val name: String,
    @ColumnInfo(name = "description") val description: String,
    @ColumnInfo(name = "image_url") val imageUrl: String,
    @ColumnInfo(name = "is_favorite") val isFavorite: Boolean = false
)

fun SpellResponse.toDatabase() = SpellEntity(
    idApi,
    name,
    description,
    imageUrl = when (name) {
        "Aberto" -> "https://pm1.narvii.com/6362/2dbe049f4a002eaf6608d75a37362aabe2a4ff23_128.jpg"
        "Accio" -> "https://es.web.img3.acsta.net/r_1280_720/newsv7/22/02/02/12/06/4644697.jpg"
        "Aguamenti" -> "https://static.wikia.nocookie.net/esharrypotter/images/1/1a/HM_Aguamenti.png/revision/latest?cb=20201015215819"
        "Alohomora" -> "https://static.wikia.nocookie.net/esharrypotter/images/9/9e/HM_Alohomora.png/revision/latest?cb=20210130191700"
        "Anapneo" -> "https://pm1.narvii.com/6283/86c9cc419f387b91cfca9cd2eec4e2cb0f15c0e5_00.jpg"
        "Aparecium" -> "https://static.wikia.nocookie.net/esharrypotter/images/0/02/Aparecium.jpg/revision/latest?cb=20141018154850"
        "Apparate" -> "https://static.wikia.nocookie.net/harrypotter/images/b/be/Dumbledore_and_Harry_performing_Apparition.gif/revision/latest?cb=20110819093308"
        "Ascendio" -> "https://static.wikia.nocookie.net/esharrypotter/images/8/8a/HM_Ascendio.png/revision/latest?cb=20210131005332"
        "Avada Kedavra" -> "https://static.wikia.nocookie.net/esharrypotter/images/a/ac/P8_Avada_Kedavra.gif/revision/latest?cb=20180507171744"
        "Avis" -> "https://static.wikia.nocookie.net/esharrypotter/images/1/15/HM_Avis.png/revision/latest?cb=20210129102637"
        "Bat" -> "https://static.wikia.nocookie.net/harrypotter/images/c/cd/Bat-Bogey_Hex_HM.png/revision/latest?cb=20210131145234"
        "Bombardo" -> "https://static.wikia.nocookie.net/esharrypotter/images/1/16/Bombarda_%28Hogarts_Mystery%29.png/revision/latest?cb=20180817035143"
        "Brackium Emendo" -> "https://static.wikia.nocookie.net/esharrypotter/images/2/27/Braquiam_Emendo.jpg/revision/latest?cb=20140728150216"
        "Capacious Extremis" -> "https://pa1.narvii.com/6872/028cf61d8fb4e5b0da2cdf0986308f05320efcf8r1-537-274_00.gif"
        "Confundo" -> "https://static.wikia.nocookie.net/esharrypotter/images/1/1d/HM_Confundus.png/revision/latest?cb=20210130233227"
        "Conjunctivitis Curse" -> "https://static.wikia.nocookie.net/harrypotter/images/7/78/Conjunctivitis_Curse.gif/revision/latest?cb=20220828005820"
        "Crinus Muto" -> "https://static.wikia.nocookie.net/esharrypotter/images/9/92/Crinus_Muto.png/revision/latest?cb=20170213044446"
        "Crucio" -> "https://static.wikia.nocookie.net/esharrypotter/images/9/9c/Voldemort_crucio_harry.gif/revision/latest?cb=20180507171146"
        "Diffindo" -> "https://static.wikia.nocookie.net/esharrypotter/images/5/5d/Diffindo_%28Hogwarts_Mystery%29.png/revision/latest?cb=20180817035147"
        "Disillusionment Charm" -> "https://static.wikia.nocookie.net/harrypotter/images/b/b7/DisillusionmentCharmHM.png/revision/latest?cb=20201214080033"
        "Disapparate" -> "https://qph.cf2.quoracdn.net/main-qimg-f62daf6b0472b939cf4536dc541a472b-pjlq"
        "Engorgio" -> "https://static.wikia.nocookie.net/esharrypotter/images/a/ac/HM_Engorgio.png/revision/latest?cb=20210130200225"
        "Episkey" -> "https://static.wikia.nocookie.net/esharrypotter/images/0/09/HM_Episkey.png/revision/latest?cb=20210130201712"
        "Expecto patronum" -> "https://static.wikia.nocookie.net/esharrypotter/images/6/6e/PM_Patronusciervo.jpg/revision/latest/scale-to-width-down/700?cb=20170203154413"
        "Erecto" -> "https://static.wikia.nocookie.net/harrypotterfannon/images/5/5f/Erecto.gif/revision/latest?cb=20130813234321&path-prefix=es"
        "Evanesco" -> "https://static.wikia.nocookie.net/esharrypotter/images/7/76/Evanesco_%28Hogwarts_Mystery%29.png/revision/latest?cb=20180817035148"
        "Expelliarmus" -> "https://static.wikia.nocookie.net/esharrypotter/images/6/63/HM_Expelliarmus.png/revision/latest?cb=20210130190717"
        "Ferula" -> "https://static.wikia.nocookie.net/esharrypotter/images/8/89/HM_F%C3%A9rula.png/revision/latest?cb=20201125223641"
        "Fidelius Charm" -> "https://static.wikia.nocookie.net/harrypotter/images/0/0f/Harry-potter1-voldemort_cottage.jpg/revision/latest/scale-to-width-down/1000?cb=20170730194346"
        "Fiendfyre Curse" -> "https://static.wikia.nocookie.net/harrypotter/images/1/18/Harry_and_Draco.png/revision/latest/scale-to-width-down/1000?cb=20170204081554"
        "Finite Incantatem" -> "https://static.wikia.nocookie.net/esharrypotter/images/1/15/HM_Finite_Incantatem.png/revision/latest?cb=20210130210350"
        "Furnunculus Curse" -> "https://static.wikia.nocookie.net/harrypotter/images/f/f4/Furnunculus.png/revision/latest?cb=20140116223259"
        "Geminio" -> "https://static.wikia.nocookie.net/esharrypotter/images/4/4b/Geminio.gif/revision/latest?cb=20170209035723"
        "Glisseo" -> "https://pm1.narvii.com/7014/2aa923393955d27ff0ae85ad2499c2779912a6dcr1-545-307v2_uhq.jpg"
        "Homenum Revelio" -> "https://static.wikia.nocookie.net/esharrypotter/images/8/84/HM_Homenum_Revelio.png/revision/latest?cb=20210130061430"
        "Homonculus Charm" -> "https://static.wikia.nocookie.net/esharrypotter/images/2/27/Encantamiento_Homonculous.gif/revision/latest?cb=20180723173522"
        "Immobulus" -> "https://static.wikia.nocookie.net/esharrypotter/images/0/0b/HM_Immobulus.png/revision/latest?cb=20210130211935"
        "Impedimenta" -> "https://static.wikia.nocookie.net/esharrypotter/images/9/95/HM_Impedimenta.png/revision/latest?cb=20210130050626"
        "Incarcerous" -> "https://static.wikia.nocookie.net/esharrypotter/images/7/7b/HM_Incarcerous.png/revision/latest?cb=20210129094204"
        "Imperio" -> "https://static.wikia.nocookie.net/harrypotterfannon/images/c/c5/Imperio.gif/revision/latest?cb=20220919234212&path-prefix=es"
        "Impervius" -> "https://static.wikia.nocookie.net/esharrypotter/images/9/91/HM_Impervius.png/revision/latest?cb=20220721212355"
        "Incendio" -> "https://static.wikia.nocookie.net/esharrypotter/images/2/2e/HM_Incendio.png/revision/latest?cb=20210130200939"
        "Langlock" -> "https://static.wikia.nocookie.net/esharrypotter/images/7/75/HM_Palalingua.png/revision/latest?cb=20200217221456"
        "Legilimens" -> "https://media.harrypotterfanzone.com/snape-uses-legilimens.gif"
        "Levicorpus" -> "https://static.wikia.nocookie.net/esharrypotter/images/e/e3/HM_Levicorpus.png/revision/latest?cb=20210130065935"
        "Locomotor Mortis" -> "https://static.wikia.nocookie.net/esharrypotter/images/c/c5/HM_Locomotor_Mortis.png/revision/latest?cb=20210130225329"
        "Lumos" -> "https://static.wikia.nocookie.net/esharrypotter/images/c/ca/HM_Lumos.png/revision/latest?cb=20211021004314"
        "Morsmordre" -> "https://static.wikia.nocookie.net/esharrypotter/images/a/af/P6_Marca_Tenebrosa.jpg/revision/latest?cb=20111207225635"
        "Mucus Ad Nauseam" -> "https://static.wikia.nocookie.net/esharrypotter/images/9/9b/HM_Maleficio_de_los_mocos.png/revision/latest?cb=20210130055235"
        "Muffliato" -> "https://static.wikia.nocookie.net/esharrypotter/images/b/ba/HM_Muffliato.png/revision/latest?cb=20210130232037"
        "Nox" -> "https://static.wikia.nocookie.net/esharrypotter/images/d/de/HM_Nox.png/revision/latest?cb=20210130192945"
        "Obliviate" -> "https://static.wikia.nocookie.net/esharrypotter/images/5/5d/Obliviate.JPG/revision/latest/scale-to-width-down/700?cb=20111005194114"
        "Obscuro" -> "https://static.wikia.nocookie.net/esharrypotter/images/4/4c/HM_Obscuro.png/revision/latest?cb=20210131111649"
        "Oculus Reparo" -> "https://static.wikia.nocookie.net/esharrypotter/images/5/51/P1_Oculus_reparo.jpg/revision/latest?cb=20140315223043"
        "Oppugno" -> "https://static.wikia.nocookie.net/esharrypotter/images/1/10/20110819-js-hpdhp1-oppugno.gif/revision/latest?cb=20111209165538"
        "Petrificus Totalus" -> "https://static.wikia.nocookie.net/esharrypotter/images/6/61/HM_Petrificus_Totalus.png/revision/latest?cb=20210130210820"
        "Periculum" -> "https://static.wikia.nocookie.net/esharrypotter/images/8/83/P4_Chispas_rojas.gif/revision/latest?cb=20180505231232"
        "Piertotum Locomotor" -> "https://static.wikia.nocookie.net/esharrypotter/images/3/3d/P8_Piertotum_locomotor.gif/revision/latest?cb=20180507174110"
        "Protean Charm" -> "https://static.wikia.nocookie.net/harrypotter/images/c/cf/EnchantedCoin.png/revision/latest?cb=20151226020949"
        "Protego" -> "https://harrypotter.fandom.com/es/wiki/Encantamiento_escudo?file=HM_Protego.png"
        "Reducto" -> "https://static.wikia.nocookie.net/esharrypotter/images/2/24/HM_Maldici%C3%B3n_Reductora.png/revision/latest?cb=20210130060225"
        "Reducio" -> "https://static.wikia.nocookie.net/esharrypotter/images/d/dc/HM_Reducio.png/revision/latest?cb=20210130202206"
        "Renneverate" -> "https://static.wikia.nocookie.net/harrypotter/images/8/8c/Revive_Charm_WU.png/revision/latest?cb=20200922110932"
        "Reparifors" -> "https://static.wikia.nocookie.net/harrypotter/images/a/a2/HM_y2_Reparifarge.png/revision/latest?cb=20180602223725"
        "Reparo" -> "https://static.wikia.nocookie.net/esharrypotter/images/a/a7/HM_Reparo.png/revision/latest?cb=20210129084734"
        "Rictusempra" -> "https://static.wikia.nocookie.net/esharrypotter/images/6/6f/HM_Rictusempra.png/revision/latest?cb=20210130191056"
        "Riddikulus" -> "https://static.wikia.nocookie.net/esharrypotter/images/f/fa/Riddikulus.gif/revision/latest?cb=20180729232323"
        "Scourgify" -> "https://static.wikia.nocookie.net/harrypotterfannon/images/f/f5/Fregotego_ficha.png/revision/latest?cb=20220410234518&path-prefix=es"
        "Sectumsempra" -> "https://static.wikia.nocookie.net/esharrypotter/images/3/3a/Sectumempra_Curse.gif/revision/latest?cb=20180507171745"
        "Serpensortia" -> "https://static.wikia.nocookie.net/esharrypotter/images/2/2b/HM_Serpensortia.png/revision/latest?cb=20210129092905"
        "Silencio" -> "https://static.wikia.nocookie.net/esharrypotter/images/0/0d/HM_Silencio.png/revision/latest?cb=20210130224415"
        "Sonorus" -> "https://static.wikia.nocookie.net/harrypotterfannon/images/a/a7/Sonorous.jpg/revision/latest/scale-to-width-down/249?cb=20130902001614&path-prefix=es"
        "Spongify" -> "https://static.wikia.nocookie.net/esharrypotter/images/c/c1/HM_Spongify.png/revision/latest?cb=20210129085046"
        "Stupefy" -> "https://static.wikia.nocookie.net/esharrypotter/images/5/55/HM_Desmaius.png/revision/latest?cb=20210130051354"
        "Tarantallegra" -> "https://static.wikia.nocookie.net/esharrypotter/images/0/0e/HM_Tarantallegra.png/revision/latest?cb=20230224005606"
        "Unbreakable Vow" -> "https://static.wikia.nocookie.net/harrypotter/images/2/2c/Unbreakable_Vow.jpg/revision/latest/scale-to-width-down/700?cb=20090523234232"
        "Wingardium Leviosa" -> "https://static.wikia.nocookie.net/esharrypotter/images/0/0e/HM_Wingardium_Leviosa.png/revision/latest?cb=20210130191416"
        else -> "https://cdn.hobbyconsolas.com/sites/navi.axelspringer.es/public/styles/1200/public/media/image/2019/09/expelliarmus-harry-potter.jpg?itok=4Z_55qWw"
    }
)

fun Spell.toDatabase() = SpellEntity(
    idApiSpell,
    name,
    description,
    imageUrl,
    isFavorite = isFavorite
)