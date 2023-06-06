package com.antelo97.harrypotterapp.domain.model

import com.antelo97.harrypotterapp.data.database.model_entity.SpeciesEntity

data class Species(
    private val idApiSpecies: Int,
    private val name: String,
    private val native_: String,
    private val imageUrl: String,
    var isFavorite: Boolean
) {
    fun getIdApiSpecies(): Int {
        return idApiSpecies
    }

    fun getName(): String {
        return name
    }

    fun getNative(): String {
        return native_
    }

    fun getImageUrl(): String {
        return imageUrl
    }
}

fun SpeciesEntity.toDomain() = Species(idApiSpecies, name, native_, imageUrl, isFavorite)