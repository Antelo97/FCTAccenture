package com.antelo97.harrypotterapp.data.database.model_entity

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

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
    @ColumnInfo(name = "image_url") val imageUrl: String
)