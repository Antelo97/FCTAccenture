package com.antelo97.harrypotterapp.domain.usecase

import com.antelo97.harrypotterapp.data.repository.SpeciesRepository
import com.antelo97.harrypotterapp.domain.model.Species
import javax.inject.Inject

class GetSpeciesUC @Inject constructor(private val repository: SpeciesRepository) {

    suspend operator fun invoke(): List<Species> {
        val query: List<Species> = repository.getSpeciesFromDatabase()

        return if (query.isEmpty()) {
            repository.insertSpecies()
            repository.getSpeciesFromDatabase()
        } else {
            query
        }
    }
}