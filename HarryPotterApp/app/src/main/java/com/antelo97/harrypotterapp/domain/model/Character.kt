package com.antelo97.harrypotterapp.domain.model

import com.antelo97.harrypotterapp.data.database.model_entity.BookEntity
import com.antelo97.harrypotterapp.data.database.model_entity.CharacterEntity
import com.antelo97.harrypotterapp.data.network.model_response.BookResponse
import com.antelo97.harrypotterapp.data.network.model_response.CharacterResponse
import com.antelo97.harrypotterapp.data.network.model_response.WandResponse
import com.antelo97.harrypotterapp.domain.model.Character

data class Character(
    val name: String,
    val species: String,
    val gender: String,
    val house: String,
    val yearOfBirth: Int,
    val isWizard: Boolean,
    val ancestry: String,
    val wand: WandResponse,
    val patronus: String,
    val isHogwartsStudent: Boolean,
    val isHogwartsStaff: Boolean,
    val actor: String,
    val isAlive: Boolean,
    val imageUrl: String
)

fun CharacterResponse.toDomain() = Character(
    name,
    species,
    gender,
    house,
    yearOfBirth,
    isWizard,
    ancestry,
    wand,
    patronus,
    isHogwartsStudent,
    isHogwartsStaff,
    actor,
    isAlive,
    imageUrl,
)

fun CharacterEntity.toDomain() = Character(
    name,
    species,
    gender,
    house,
    yearOfBirth,
    isWizard,
    ancestry,
    wand,
    patronus,
    isHogwartsStudent,
    isHogwartsStaff,
    actor,
    isAlive,
    imageUrl,
)