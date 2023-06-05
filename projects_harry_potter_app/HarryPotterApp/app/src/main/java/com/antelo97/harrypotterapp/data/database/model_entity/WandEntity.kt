package com.antelo97.harrypotterapp.data.database.model_entity

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.ForeignKey
import androidx.room.PrimaryKey

@Entity(
    tableName = "Wands", foreignKeys = [ForeignKey(
        entity = CharacterEntity::class,
        parentColumns = ["id_api_character"],
        childColumns = ["id_foreign_character"]
    )]
)
data class WandEntity(
    @PrimaryKey(autoGenerate = true)
    @ColumnInfo(name = "id_room_wand") val idRoomWand: Int = 0,
    @ColumnInfo(name = "id_foreign_character") val idForeignCharacter: String,
    @ColumnInfo(name = "wood") val wood: String,
    @ColumnInfo(name = "core") val core: String,
    @ColumnInfo(name = "length") val length: Double
)