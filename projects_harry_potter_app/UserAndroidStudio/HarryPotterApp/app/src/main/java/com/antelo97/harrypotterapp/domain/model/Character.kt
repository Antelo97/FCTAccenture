package com.antelo97.harrypotterapp.domain.model

import com.antelo97.harrypotterapp.data.database.model_entity.CharacterEntity

data class Character(
    private val idApiCharacter: String,
    private val name: String,
    private val species: String,
    private val gender: String,
    private val house: String,
    private val yearOfBirth: Int,
    private val isWizard: Boolean,
    private val ancestry: String,
    private val patronus: String,
    private val isHogwartsStudent: Boolean,
    private val isHogwartsStaff: Boolean,
    private val actor: String,
    private val isAlive: Boolean,
    private val imageUrl: String,
    var isFavorite: Boolean,
    private val imageUrlHouse: String,
    private val wand: Wand,
) {
    fun getIdApiCharacter(): String {
        return idApiCharacter
    }

    fun getName(): String {
        return name
    }

    fun getSpecies(): String {
        return species
    }

    fun getGender(): String {
        return gender
    }

    fun getHouse(): String {
        return house
    }

    fun getYearOfBirth(): Int {
        return yearOfBirth
    }

    fun isWizard(): Boolean {
        return isWizard
    }

    fun getAncestry(): String {
        return ancestry
    }

    fun getPatronus(): String {
        return patronus
    }

    fun isHogwartsStudent(): Boolean {
        return isHogwartsStudent
    }

    fun isHogwartsStaff(): Boolean {
        return isHogwartsStaff
    }

    fun getActor(): String {
        return actor
    }

    fun isAlive(): Boolean {
        return isAlive
    }

    fun getImageUrl(): String {
        return imageUrl
    }

    fun getImageUrlHouse(): String {
        return imageUrlHouse
    }

    fun getWand(): Wand {
        return wand
    }
}

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
