package com.antelo97.harrypotterapp.data.database.dao

import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.antelo97.harrypotterapp.data.database.model_entity.CharacterEntity

interface CharacterDao {

    @Query("SELECT * FROM Characters")
    suspend fun getAllCharacters(): List<CharacterEntity>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertAllCharactersAndWands(characters: List<CharacterEntity>)

    @Query("DELETE FROM Characters")
    suspend fun deleteAllCharacters()
}