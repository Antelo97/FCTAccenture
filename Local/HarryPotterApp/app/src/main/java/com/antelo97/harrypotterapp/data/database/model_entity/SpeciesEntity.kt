package com.antelo97.harrypotterapp.data.database.model_entity

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey
import com.antelo97.harrypotterapp.data.network.model_response.SpeciesResponse
import com.antelo97.harrypotterapp.domain.model.Species

@Entity(tableName = "Species")
data class SpeciesEntity(
    @PrimaryKey(autoGenerate = false)
    @ColumnInfo(name = "id_api_species") val idApiSpecies: Int,
    @ColumnInfo(name = "name") val name: String,
    @ColumnInfo(name = "native") val native_: String,
    @ColumnInfo(name = "image_url") val imageUrl: String,
    @ColumnInfo(name = "is_favorite") val isFavorite: Boolean = false
)

fun SpeciesResponse.toDatabase() = SpeciesEntity(
    idApiSpecies = idApi,
    name = name,
    native_ = when (native_) {
        null -> ""
        else -> native_
    },
    imageUrl = when (name) {
        "Unicorn" -> "https://static.wikia.nocookie.net/harrypotter/images/e/e4/Unicorn_FBCFTWW.png/revision/latest?cb=20161130204538"
        "Ghost" -> "https://static.wikia.nocookie.net/harrypotter/images/6/60/Ghost_PM.png/revision/latest?cb=20210903044914"
        "Dementor" -> "https://static.wikia.nocookie.net/esharrypotter/images/5/5a/PM_Dementor.jpg/revision/latest/scale-to-width-down/700?cb=20161206115709"
        "Boggart" -> "https://static.wikia.nocookie.net/esharrypotter/images/9/96/HPotter_boggart_dementor.jpg/revision/latest?cb=20131229204619"
        "Grindylow" -> "https://static.wikia.nocookie.net/esharrypotter/images/9/93/CMM_Grindylow.png/revision/latest?cb=20180127000432"
        "Hinkypunk" -> "https://static.wikia.nocookie.net/esharrypotter/images/e/e5/PM_Hinkypunk.png/revision/latest/scale-to-width-down/700?cb=20220129154832"
        "Veela" -> "https://static.wikia.nocookie.net/esharrypotter/images/b/bd/P4_Fleur_Delacour.png/revision/latest/scale-to-width-down/700?cb=20220208171715"
        "Leprechaun" -> "https://static.wikia.nocookie.net/esharrypotter/images/2/23/Leprechaun.jpg/revision/latest?cb=20131129222644"
        "Blast-Ended Skrewt" -> "https://static.wikia.nocookie.net/harrypotter/images/9/99/Blast-Ended_Skrewt_PM.png/revision/latest/scale-to-width-down/700?cb=20220126040215"
        "Abraxan" -> "https://static.wikia.nocookie.net/esharrypotter/images/5/51/Abraxan_PM.jpg/revision/latest/scale-to-width-down/624?cb=20180112145136"
        "Niffler" -> "https://static.wikia.nocookie.net/esharrypotter/images/b/b1/CMM_Escarbato.png/revision/latest?cb=20180127004233"
        "Sphinx" -> "https://static.wikia.nocookie.net/harrypotter/images/f/f4/Sphinx_FBCFWW.png/revision/latest?cb=20170413064440"
        "Spider" -> "https://static.wikia.nocookie.net/harrypotter/images/2/2c/Aragog_in_his_lair_COSF.jpg/revision/latest?cb=20100611145604"
        "Doxy" -> "https://static.wikia.nocookie.net/esharrypotter/images/9/9b/Doxy_FB.png/revision/latest?cb=20180126232855"
        "Goblin" -> "https://static.wikia.nocookie.net/harrypotter/images/5/53/Griphook_TDH_SF.png/revision/latest?cb=20161215062124"
        "Ghoul" -> "https://static.wikia.nocookie.net/esharrypotter/images/6/6e/HM_Ghoul_camale%C3%B3n.png/revision/latest?cb=20210219203056"
        "Inferius" -> "https://static.wikia.nocookie.net/esharrypotter/images/b/b0/Inferius.jpg/revision/latest?cb=20110403212936"
        "Wizardkind" -> "https://static.wikia.nocookie.net/harrypotter/images/9/97/Wizardspic.png/revision/latest?cb=20130325224915"
        "Blood-Sucking Bugbear" -> "data:image/jpeg;base64,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"
        "Bowtruckle" -> "https://static.wikia.nocookie.net/esharrypotter/images/5/55/CMM_Bowtruckle.png/revision/latest?cb=20180126231251"
        else -> ""
    }
)

fun Species.toDatabase() = SpeciesEntity(idApiSpecies, name, native_, imageUrl, isFavorite)