package com.antelo97.harrypotterapp.domain.model

import com.antelo97.harrypotterapp.data.database.model_entity.SpellEntity

data class Spell(
    val idApiSpell: String,
    var name: String,
    val description: String,
    val isFavorite: Boolean
)

fun SpellEntity.toDomain() = Spell(idApiSpell, name, description, isFavorite)