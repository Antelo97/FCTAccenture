package com.antelo97.harrypotterapp.domain.usecase.spell

import com.antelo97.harrypotterapp.data.repository.SpellRepository
import com.antelo97.harrypotterapp.domain.model.Spell
import javax.inject.Inject

class DeleteFavSpellsUC @Inject constructor(private val repository: SpellRepository) {

    suspend operator fun invoke() {
        val noFavSpells: List<Spell> = repository.getSpellsFromDatabase().map { spell ->
            spell.copy(isFavorite = false)
        }
        repository.updateSpells(noFavSpells)
    }
}