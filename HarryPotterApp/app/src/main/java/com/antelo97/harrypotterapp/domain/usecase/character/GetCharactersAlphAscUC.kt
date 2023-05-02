package com.antelo97.harrypotterapp.domain.usecase.character

import javax.inject.Inject

class GetCharactersAlphAscUC @Inject constructor() {

    operator fun invoke(foundCharacters: List<com.antelo97.harrypotterapp.domain.model.Character>) =
        foundCharacters.sortedBy { it.name }
}