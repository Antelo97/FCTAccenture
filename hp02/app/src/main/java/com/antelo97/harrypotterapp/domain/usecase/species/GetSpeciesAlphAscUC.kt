package com.antelo97.harrypotterapp.domain.usecase.species

import com.antelo97.harrypotterapp.domain.model.Species
import javax.inject.Inject

class GetSpeciesAlphAscUC @Inject constructor() {

    operator fun invoke(foundSpecies: List<Species>): List<Species> =
        foundSpecies.sortedBy { it.name }
}