package com.antelo97.harrypotterapp.domain.usecase

import com.antelo97.harrypotterapp.data.repository.CharacterRepository
import javax.inject.Inject

class GetCharactersUC @Inject constructor(private val repository: CharacterRepository) {

    suspend operator fun invoke(): List<com.antelo97.harrypotterapp.domain.model.Character> {
        repository.insertAllCharactersAndWands()
        return repository.getAllCharactersFromDatabase()
    }
}