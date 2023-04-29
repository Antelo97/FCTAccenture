package com.antelo97.harrypotterapp.data.repository

import com.antelo97.harrypotterapp.data.database.dao.SpeciesDao
import com.antelo97.harrypotterapp.data.database.model_entity.SpeciesEntity
import com.antelo97.harrypotterapp.data.database.model_entity.toDatabase
import com.antelo97.harrypotterapp.data.network.api.SpeciesService
import com.antelo97.harrypotterapp.domain.model.Species
import com.antelo97.harrypotterapp.domain.model.Spell
import com.antelo97.harrypotterapp.domain.model.toDomain
import javax.inject.Inject

class SpeciesRepository @Inject constructor(
    private val api: SpeciesService,
    private val dao: SpeciesDao
) {

    suspend fun insertSpecies() {
        val species: List<SpeciesEntity> = api.getSpecies().map { it.toDatabase() }

        deleteSpecies()
        dao.insertSpecies(species)
    }

    suspend fun getSpeciesFromDatabase(): List<Species> {
        return dao.getSpecies().map { it.toDomain() }
    }

    suspend fun deleteSpecies() {
        dao.deleteSpecies()
    }

    suspend fun getSpeciesByName(searchQuery: String): List<Species> {
        return dao.getSpeciesByName(searchQuery).map { it.toDomain() }
    }

    suspend fun updateSpecies(species: Species) {
        dao.updateSpecies(species.toDatabase())
    }
}