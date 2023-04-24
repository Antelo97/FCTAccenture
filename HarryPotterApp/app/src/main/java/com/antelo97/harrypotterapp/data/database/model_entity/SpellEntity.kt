package com.antelo97.harrypotterapp.data.database.model_entity

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey
import com.antelo97.harrypotterapp.data.network.model_response.SpellResponse

@Entity(tableName = "Spells")
data class SpellEntity(
    @PrimaryKey(autoGenerate = false)
    @ColumnInfo(name = "id_api_spell") val idApiSpell: String,
    @ColumnInfo(name = "name") val name: String,
    @ColumnInfo(name = "description") val description: String,
    @ColumnInfo(name = "is_favorite") val isFavorite: Boolean = false
)

fun SpellResponse.toDatabase() = SpellEntity(idApi, name, description)
