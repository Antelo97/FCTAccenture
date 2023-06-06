package com.antelo97.harrypotterapp.domain.model

import com.antelo97.harrypotterapp.data.database.model_entity.SpellEntity

data class Spell(
    private  val idApiSpell: String,
    private  val name: String,
    private  val description: String,
    private  val imageUrl: String,
    var isFavorite: Boolean
){
    fun getIdApiSpell(): String {
        return idApiSpell
    }

    fun getName(): String {
        return name
    }

    fun getDescription(): String {
        return description
    }

    fun getImageUrl(): String {
        return imageUrl
    }
}

fun SpellEntity.toDomain() = Spell(idApiSpell, name, description, imageUrl, isFavorite)