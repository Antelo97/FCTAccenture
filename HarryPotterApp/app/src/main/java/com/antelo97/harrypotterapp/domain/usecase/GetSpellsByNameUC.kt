package com.antelo97.harrypotterapp.domain.usecase

import com.antelo97.harrypotterapp.data.repository.SpellRepository
import com.antelo97.harrypotterapp.domain.model.Spell
import javax.inject.Inject

class GetSpellsByNameUC @Inject constructor(private val repository: SpellRepository) {

    suspend operator fun invoke(searchQuery: String): List<Spell> {
        return repository.getSpellsByName(searchQuery)
    }
}