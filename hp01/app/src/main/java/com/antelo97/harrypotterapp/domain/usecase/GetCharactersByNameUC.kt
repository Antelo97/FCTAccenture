package com.antelo97.harrypotterapp.domain.usecase

import com.antelo97.harrypotterapp.data.repository.CharacterRepository
import javax.inject.Inject

class GetCharactersByNameUC  @Inject constructor(private val repository: CharacterRepository){

    suspend operator fun invoke(searchQuery: String): List<com.antelo97.harrypotterapp.domain.model.Character> {
        return repository.getCharactersByName(searchQuery)
    }
}