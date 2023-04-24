package com.antelo97.harrypotterapp.data.database.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.antelo97.harrypotterapp.data.database.model_entity.BookEntity
import com.antelo97.harrypotterapp.data.database.model_entity.SpeciesEntity

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
}