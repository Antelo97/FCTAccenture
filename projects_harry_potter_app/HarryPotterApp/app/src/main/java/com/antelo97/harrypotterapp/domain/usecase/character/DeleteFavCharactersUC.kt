package com.antelo97.harrypotterapp.domain.usecase.character

import com.antelo97.harrypotterapp.data.repository.CharacterRepository
import javax.inject.Inject

class DeleteFavCharactersUC @Inject constructor(private val repository: CharacterRepository) {

    suspend operator fun invoke() {
        val noFavCharacters = repository.getCharactersFromDatabase().map { character ->
            character.copy(isFavorite = false)
        }
        repository.updateCharacters(noFavCharacters)
    }
}