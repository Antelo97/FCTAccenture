package com.antelo97.harrypotterapp.domain.model

import com.antelo97.harrypotterapp.data.database.model_entity.WandEntity

data class Wand(
    private val idRoomWand: Int,
    private val idForeignCharacter: String,
    private val wood: String,
    private val core: String,
    private val length: Double,
) {
    fun getIdRoomWand(): Int {
        return idRoomWand
    }

    fun getIdForeignCharacter(): String {
        return idForeignCharacter
    }

    fun getWood(): String {
        return wood
    }

    fun getCore(): String {
        return core
    }

    fun getLength(): Double {
        return length
    }
}

fun WandEntity.toDomain() = Wand(
    idRoomWand,
    idForeignCharacter,
    wood,
    core,
    length,
)