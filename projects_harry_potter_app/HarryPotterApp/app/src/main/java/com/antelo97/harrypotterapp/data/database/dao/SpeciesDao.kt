package com.antelo97.harrypotterapp.data.database.dao

import androidx.room.*
import com.antelo97.harrypotterapp.data.database.model_entity.BookEntity
import com.antelo97.harrypotterapp.data.database.model_entity.SpeciesEntity
import com.antelo97.harrypotterapp.domain.model.Species

@Dao
interface SpeciesDao {

    @Query("SELECT * FROM Species")
    suspend fun getSpecies(): List<SpeciesEntity>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertSpecies(species: List<SpeciesEntity>)

    @Query("DELETE FROM Species")
    suspend fun deleteSpecies()

    @Query("SELECT * FROM Species WHERE name LIKE '%' || :searchQuery || '%'")
    suspend fun getSpeciesByName(searchQuery: String): List<SpeciesEntity>

    @Update
    suspend fun updateSpecies(species: SpeciesEntity)

    @Update
    suspend fun updateSpeciesList(species: List<SpeciesEntity>) // List para diferenciar
}