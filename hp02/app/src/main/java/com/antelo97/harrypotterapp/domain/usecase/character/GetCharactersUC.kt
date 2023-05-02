package com.antelo97.harrypotterapp.domain.usecase.character

import com.antelo97.harrypotterapp.data.repository.CharacterRepository
import javax.inject.Inject

class GetCharactersUC @Inject constructor(private val repository: CharacterRepository) {

    suspend operator fun invoke(): List<com.antelo97.harrypotterapp.domain.model.Character> {
        val query = repository.getCharactersFromDatabase()

        return if (query.isEmpty()) {
            repository.insertCharactersAndWands()
            repository.getCharactersFromDatabase()
        } else {
            query
        }
    }
}