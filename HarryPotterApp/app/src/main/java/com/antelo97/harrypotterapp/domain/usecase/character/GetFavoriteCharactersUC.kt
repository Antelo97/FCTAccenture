package com.antelo97.harrypotterapp.domain.usecase.character

import com.antelo97.harrypotterapp.data.repository.CharacterRepository
import javax.inject.Inject

class GetFavoriteCharactersUC @Inject constructor(private val repository: CharacterRepository) {

    suspend operator fun invoke(): List<com.antelo97.harrypotterapp.domain.model.Character> =
        repository.getCharactersFromDatabase().filter { it.isFavorite }
}