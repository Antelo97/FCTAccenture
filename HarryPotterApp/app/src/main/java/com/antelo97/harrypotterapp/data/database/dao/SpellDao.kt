package com.antelo97.harrypotterapp.data.database.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.antelo97.harrypotterapp.data.database.model_entity.SpellEntity

@Dao
interface SpellDao {

    @Query("SELECT * FROM Spells")
    suspend fun getAllSpells(): List<SpellEntity>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertAllSpells(characters: List<SpellEntity>)

    @Query("DELETE FROM Spells")
    suspend fun deleteAllSpells()
}