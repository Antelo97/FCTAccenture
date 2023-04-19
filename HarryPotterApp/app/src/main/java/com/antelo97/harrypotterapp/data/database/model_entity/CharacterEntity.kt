package com.antelo97.harrypotterapp.data.database.model_entity

import androidx.room.*
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

    @Relation(
        parentColumn = "id_api_character",
        entityColumn = "id_foreign_character"
    )
    val wand: WandEntity
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
    imageUrl,
    wand = WandEntity(
        idForeignCharacter = idApi,
        wood = wand.wood,
        core = wand.core,
        length = wand.length,
        character = null
    )
)

// Model
