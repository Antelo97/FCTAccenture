package com.antelo97.harrypotterapp.domain.model

import com.antelo97.harrypotterapp.data.database.model_entity.BookEntity
import com.antelo97.harrypotterapp.data.database.model_entity.WandEntity
import com.antelo97.harrypotterapp.data.network.model_response.BookResponse

data class Wand(
    val idRoomWand: Int,
    val idForeignCharacter: String,
    val wood: String,
    val core: String,
    val length: Int,
    val character: Character?
)

fun WandEntity.toDomain() = Wand(
    idRoomWand,
    idForeignCharacter,
    wood,
    core,
    length,
    null
)