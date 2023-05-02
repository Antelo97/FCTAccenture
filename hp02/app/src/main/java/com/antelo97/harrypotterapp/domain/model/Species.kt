package com.antelo97.harrypotterapp.domain.model

import com.antelo97.harrypotterapp.data.database.model_entity.SpeciesEntity

data class Species(
    val idApiSpecies: Int,
    val name: String,
    val native_: String,
    val imageUrl: String,
    var isFavorite: Boolean
)

fun SpeciesEntity.toDomain() = Species(idApiSpecies, name, native_, imageUrl, isFavorite)