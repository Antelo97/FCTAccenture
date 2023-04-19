package com.antelo97.harrypotterapp.data.repository

import com.antelo97.harrypotterapp.data.database.dao.CharacterDao
import com.antelo97.harrypotterapp.data.database.model_entity.CharacterEntity
import com.antelo97.harrypotterapp.data.database.model_entity.toDatabase
import com.antelo97.harrypotterapp.data.network.api.CharacterService
import com.antelo97.harrypotterapp.domain.model.toDomain
import javax.inject.Inject

class CharacterRepository @Inject constructor(
    private val api: CharacterService,
    private val dao: CharacterDao
) {

    suspend fun getAllCharactersFromDatabase(): List<com.antelo97.harrypotterapp.domain.model.Character> {
        val query: List<CharacterEntity> = dao.getAllCharacters()
        return query.map { it.toDomain() }
    }

    suspend fun insertAllCharactersAndWands() {
        val characters: List<CharacterEntity> = api.getAllCharacters().map { it.toDatabase() }

        deleteAllCharacters()
        dao.insertAllCharactersAndWands(characters)
    }

    private suspend fun deleteAllCharacters() {
        dao.deleteAllCharacters()
    }
}