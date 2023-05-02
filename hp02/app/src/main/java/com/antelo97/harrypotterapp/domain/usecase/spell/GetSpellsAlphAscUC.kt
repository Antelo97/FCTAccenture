package com.antelo97.harrypotterapp.domain.usecase.spell

import com.antelo97.harrypotterapp.domain.model.Book
import com.antelo97.harrypotterapp.domain.model.Spell
import javax.inject.Inject

class GetSpellsAlphAscUC @Inject constructor() {

    operator fun invoke(foundSpells: List<Spell>): List<Spell> = foundSpells.sortedBy { it.name }
}