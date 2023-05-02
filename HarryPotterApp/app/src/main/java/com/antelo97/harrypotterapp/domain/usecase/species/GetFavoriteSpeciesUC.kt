package com.antelo97.harrypotterapp.domain.usecase.species

import com.antelo97.harrypotterapp.data.repository.SpeciesRepository
import com.antelo97.harrypotterapp.domain.model.Species
import javax.inject.Inject

class GetFavoriteSpeciesUC @Inject constructor(private val repository: SpeciesRepository) {

    suspend operator fun invoke(): List<Species> =
        repository.getSpeciesFromDatabase().filter { it.isFavorite }
}