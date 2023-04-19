package com.antelo97.harrypotterapp.domain.model

import androidx.room.ColumnInfo
import androidx.room.PrimaryKey
import androidx.room.Relation
import com.antelo97.harrypotterapp.data.database.model_entity.CharacterEntity
import com.antelo97.harrypotterapp.data.database.model_entity.WandEntity
import com.antelo97.harrypotterapp.data.network.model_response.CharacterResponse
import com.antelo97.harrypotterapp.data.network.model_response.WandResponse
import com.antelo97.harrypotterapp.domain.model.Character

data class Character(
    val idApiCharacter: String,
    val name: String,
    val species: String,
    val gender: String,
    val house: String,
    val yearOfBirth: Int,
    val isWizard: Boolean,
    val ancestry: String,
    val wand: Wand,
    val patronus: String,
    val isHogwartsStudent: Boolean,
    val isHogwartsStaff: Boolean,
    val actor: String,
    val isAlive: Boolean,
    val imageUrl: String,
    val isFavorite: Boolean
)

fun CharacterEntity.toDomain() = Character(
    idApiCharacter,
    name,
    species,
    gender,
    house,
    yearOfBirth,
    isWizard,
    ancestry,
    wand = Wand(wand.idRoomWand, wand.idForeignCharacter, wand.wood, wand.core, wand.length, null),
    patronus,
    isHogwartsStudent,
    isHogwartsStaff,
    actor,
    isAlive,
    imageUrl,
    isFavorite
)
