package com.antelo97.harrypotterapp.data.database.model_entity

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey
import com.antelo97.harrypotterapp.data.network.model_response.SpeciesResponse

@Entity(tableName = "Species")
data class SpeciesEntity(
    @PrimaryKey(autoGenerate = false)
    @ColumnInfo(name = "id_api_species") val idApiSpecies: Int,
    @ColumnInfo(name = "name") val name: String,
    @ColumnInfo(name = "native") val native_: String,
    @ColumnInfo(name = "is_favorite") val isFavorite: Boolean = false
)

fun SpeciesResponse.toDatabase() = SpeciesEntity(
    idApiSpecies = idApi,
    name = name,
    native_ = when (native_) {
        null -> ""
        else -> native_
    }
)