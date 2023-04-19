package com.antelo97.harrypotterapp.data.database.model_entity

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey
import androidx.room.Relation
import com.antelo97.harrypotterapp.data.network.model_response.CharacterResponse
import com.antelo97.harrypotterapp.data.network.model_response.WandResponse

@Entity(tableName = "Wands")
data class WandEntity(
    @PrimaryKey(autoGenerate = true)
    @ColumnInfo(name = "id_room_wand") val idRoomWand: Int = 0,
    @ColumnInfo(name = "id_foreign_character") val idForeignCharacter: String,
    @ColumnInfo(name = "wood") val wood: String,
    @ColumnInfo(name = "core") val core: String,
    @ColumnInfo(name = "length") val length: Int,

    @Relation(
        parentColumn = "id_foreign_character",
        entityColumn = "id_api_character"
    )
    val character: CharacterEntity?
)






