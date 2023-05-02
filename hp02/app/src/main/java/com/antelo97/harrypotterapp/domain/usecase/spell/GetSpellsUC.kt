package com.antelo97.harrypotterapp.domain.usecase.spell

import com.antelo97.harrypotterapp.data.repository.SpellRepository
import com.antelo97.harrypotterapp.domain.model.Spell
import javax.inject.Inject

class GetSpellsUC @Inject constructor(private val repository: SpellRepository) {

    suspend operator fun invoke(): List<Spell> {
        val query: List<Spell> = repository.getSpellsFromDatabase()

        return if (query.isEmpty()) {
            repository.insertSpells()
            repository.getSpellsFromDatabase()
        } else {
            query
        }
    }
}