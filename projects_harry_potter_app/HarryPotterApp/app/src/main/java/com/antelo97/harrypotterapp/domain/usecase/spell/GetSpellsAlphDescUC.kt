package com.antelo97.harrypotterapp.domain.usecase.spell

import com.antelo97.harrypotterapp.domain.model.Spell
import javax.inject.Inject

class GetSpellsAlphDescUC @Inject constructor() {

    operator fun invoke(foundSpells: List<Spell>) = foundSpells.sortedByDescending { it.name }
}