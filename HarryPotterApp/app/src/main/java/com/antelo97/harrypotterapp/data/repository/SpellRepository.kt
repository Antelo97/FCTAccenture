package com.antelo97.harrypotterapp.data.repository

import com.antelo97.harrypotterapp.data.database.dao.SpellDao
import com.antelo97.harrypotterapp.data.database.model_entity.SpellEntity
import com.antelo97.harrypotterapp.data.database.model_entity.toDatabase
import com.antelo97.harrypotterapp.data.network.api.SpellService
import com.antelo97.harrypotterapp.domain.model.Spell
import com.antelo97.harrypotterapp.domain.model.toDomain
import javax.inject.Inject

class SpellRepository @Inject constructor(
    private val api: SpellService,
    private val dao: SpellDao
) {

    suspend fun getSpellsFromDatabase(): List<Spell> {
        return dao.getSpells().map { it.toDomain() }
    }

    suspend fun insertSpells() {
        val spells: List<SpellEntity> = api.getSpells().map { it.toDatabase() }

        deleteSpells()
        dao.insertSpells(spells)
    }

    suspend fun deleteSpells() {
        dao.deleteSpells()
    }

    suspend fun getSpellsByName(searchQuery: String): List<Spell> {
        return dao.getSpellsByName(searchQuery).map { it.toDomain() }
    }

    suspend fun getFavoriteSpells(): List<Spell> {
        return dao.getFavoriteSpells().map { it.toDomain() }
    }
}