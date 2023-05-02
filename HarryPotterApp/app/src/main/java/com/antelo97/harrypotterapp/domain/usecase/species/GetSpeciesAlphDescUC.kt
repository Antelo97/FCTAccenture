package com.antelo97.harrypotterapp.domain.usecase.species

import com.antelo97.harrypotterapp.domain.model.Species
import javax.inject.Inject

class GetSpeciesAlphDescUC @Inject constructor() {

    operator fun invoke(foundSpecies: List<Species>) = foundSpecies.sortedByDescending { it.name }
}