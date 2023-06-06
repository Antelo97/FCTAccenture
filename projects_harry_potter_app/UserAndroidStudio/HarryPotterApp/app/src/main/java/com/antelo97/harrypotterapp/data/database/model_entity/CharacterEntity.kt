package com.antelo97.harrypotterapp.data.database.model_entity

import androidx.room.ColumnInfo
import androidx.room.Embedded
import androidx.room.Entity
import androidx.room.PrimaryKey
import com.antelo97.harrypotterapp.data.network.model_response.CharacterResponse

@Entity(tableName = "Characters")
data class CharacterEntity(
    @PrimaryKey(autoGenerate = false)
    @ColumnInfo(name = "id_api_character") val idApiCharacter: String,
    @ColumnInfo(name = "name") val name: String,
    @ColumnInfo(name = "species") val species: String,
    @ColumnInfo(name = "gender") val gender: String,
    @ColumnInfo(name = "house") val house: String,
    @ColumnInfo(name = "year_of_birth") val yearOfBirth: Int,
    @ColumnInfo(name = "is_wizard") val isWizard: Boolean,
    @ColumnInfo(name = "ancestry") val ancestry: String,
    @ColumnInfo(name = "patronus") val patronus: String,
    @ColumnInfo(name = "is_hogwarts_student") val isHogwartsStudent: Boolean,
    @ColumnInfo(name = "is_hogwarts_staff") val isHogwartsStaff: Boolean,
    @ColumnInfo(name = "actor") val actor: String,
    @ColumnInfo(name = "is_alive") val isAlive: Boolean,
    @ColumnInfo(name = "image_url") val imageUrl: String,
    @ColumnInfo(name = "is_favorite") val isFavorite: Boolean = false,
    @ColumnInfo(name = "image_url_house") val imageUrlHouse: String,
    @Embedded val wand: WandEntity
)

fun CharacterResponse.toDatabase() = CharacterEntity(
    idApi,
    name,
    species,
    gender,
    house,
    yearOfBirth,
    isWizard,
    ancestry,
    patronus,
    isHogwartsStudent,
    isHogwartsStaff,
    actor,
    isAlive,
    imageUrl = when (imageUrl) {
        "" -> "https://objetivoligar.com/wp-content/uploads/2017/03/blank-profile-picture-973460_1280.jpg"
        else -> imageUrl
    },
    imageUrlHouse = when (house) {
        "Gryffindor" -> "https://static.wikia.nocookie.net/harrypotter/images/b/b1/Gryffindor_ClearBG.png"
        "Hufflepuff" -> "https://static.wikia.nocookie.net/harrypotter/images/0/06/Hufflepuff_ClearBG.png"
        "Slytherin" -> "https://static.wikia.nocookie.net/harrypotter/images/0/00/Slytherin_ClearBG.png"
        "Ravenclaw" -> "https://static.wikia.nocookie.net/harrypotter/images/7/71/Ravenclaw_ClearBG.png"
        else -> ""
    },
    wand = WandEntity(
        idForeignCharacter = idApi,
        wood = wand.wood,
        core = wand.core,
        length = wand.length,
    )
)

fun com.antelo97.harrypotterapp.domain.model.Character.toDatabase() = CharacterEntity(
    getIdApiCharacter(),
    getName(),
    getSpecies(),
    getGender(),
    getHouse(),
    getYearOfBirth(),
    isWizard(),
    getAncestry(),
    getPatronus(),
    isHogwartsStudent(),
    isHogwartsStaff(),
    getActor(),
    isAlive(),
    getImageUrl(),
    isFavorite,
    getImageUrl(),
    wand = WandEntity(getWand().getIdRoomWand(), getWand().getIdForeignCharacter(), getWand().getWood(), getWand().getCore(), getWand().getLength())
)
