package com.antelo97.harrypotterapp.data.repository

import com.antelo97.harrypotterapp.data.database.dao.CharacterDao
import com.antelo97.harrypotterapp.data.database.model_entity.BookEntity
import com.antelo97.harrypotterapp.data.database.model_entity.CharacterEntity
import com.antelo97.harrypotterapp.data.database.model_entity.toDatabase
import com.antelo97.harrypotterapp.data.network.api.CharacterService
import com.antelo97.harrypotterapp.data.network.model_response.BookResponse
import com.antelo97.harrypotterapp.data.network.model_response.CharacterResponse
import com.antelo97.harrypotterapp.domain.model.Book
import com.antelo97.harrypotterapp.domain.model.toDomain
import javax.inject.Inject

class CharacterRepository @Inject constructor(
    private val api: CharacterService,
    private val dao: CharacterDao
) {

    suspend fun getAllCharactersFromApi(): List<Book>? {
        val response: List<CharacterResponse> = api.getAllCharacters()

        return if (response.isNotEmpty()) {
            delet()
            insertAllBooks(response.map { it.toDatabase() })
            response.map { it.toDomain() }
        } else {
            getAllBooksFromDatabase()
        }
    }

    suspend fun getAllBooksFromDatabase(): List<CharacterEntity> {
        val query: List<CharacterEntity> = dao.getAllCharacters()
        return query.map { it.toDomain() }
    }

    suspend fun insertAllCharacters(characters: List<CharacterEntity>) {
        dao.insertAllCharacters(characters)
    }

    suspend fun deleteAllCharacters() {
        dao.deleteAllCharacters()
    }
}