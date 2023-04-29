package com.antelo97.harrypotterapp.domain.model

import com.antelo97.harrypotterapp.data.database.model_entity.CharacterEntity

data class Character(
    val idApiCharacter: String,
    val name: String,
    val species: String,
    val gender: String,
    val house: String,
    val yearOfBirth: Int,
    val isWizard: Boolean,
    val ancestry: String,
    val patronus: String,
    val isHogwartsStudent: Boolean,
    val isHogwartsStaff: Boolean,
    val actor: String,
    val isAlive: Boolean,
    val imageUrl: String,
    var isFavorite: Boolean,
    val imageUrlHouse: String,
    val wand: Wand,
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
    patronus,
    isHogwartsStudent,
    isHogwartsStaff,
    actor,
    isAlive,
    imageUrl,
    isFavorite,
    imageUrlHouse,
    wand.toDomain(),

    /*wand = Wand(
        wand.idRoomWand,
        wand.idForeignCharacter,
        wand.wood,
        wand.core,
        wand.length
    )*/
)
