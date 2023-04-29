package com.antelo97.harrypotterapp.domain.model

import com.antelo97.harrypotterapp.data.database.model_entity.WandEntity

data class Wand(
    val idRoomWand: Int,
    val idForeignCharacter: String,
    val wood: String,
    val core: String,
    val length: Double,
)

fun WandEntity.toDomain() = Wand(
    idRoomWand,
    idForeignCharacter,
    wood,
    core,
    length,
)