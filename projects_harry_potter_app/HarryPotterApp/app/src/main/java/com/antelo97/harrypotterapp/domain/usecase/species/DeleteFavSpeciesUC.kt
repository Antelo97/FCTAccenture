package com.antelo97.harrypotterapp.domain.usecase.species

import com.antelo97.harrypotterapp.data.repository.SpeciesRepository
import com.antelo97.harrypotterapp.domain.model.Species
import javax.inject.Inject

class DeleteFavSpeciesUC @Inject constructor(private val repository: SpeciesRepository) {

    suspend operator fun invoke() {
        val noFavSpecies: List<Species> = repository.getSpeciesFromDatabase().map { species ->
            species.copy(isFavorite = false)
        }
        repository.updateSpeciesList(noFavSpecies)
    }
}