package com.antelo97.harrypotterapp.domain.usecase.character

import com.antelo97.harrypotterapp.data.repository.CharacterRepository
import javax.inject.Inject

class UpdateCharactersUC @Inject constructor(private val repository: CharacterRepository) {

    suspend operator fun invoke(character: com.antelo97.harrypotterapp.domain.model.Character) {
        repository.updateCharacter(character)
    }
}