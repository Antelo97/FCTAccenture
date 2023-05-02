package com.antelo97.harrypotterapp.domain.usecase.spell

import com.antelo97.harrypotterapp.data.repository.SpellRepository
import com.antelo97.harrypotterapp.domain.model.Spell
import javax.inject.Inject

class GetFavoriteSpellsUC @Inject constructor(private val repository: SpellRepository) {

    suspend operator fun invoke(): List<Spell> = repository.getFavoriteSpells()
}