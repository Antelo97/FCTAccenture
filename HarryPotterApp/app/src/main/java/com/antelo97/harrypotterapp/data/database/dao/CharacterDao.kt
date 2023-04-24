package com.antelo97.harrypotterapp.data.database.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.antelo97.harrypotterapp.data.database.model_entity.BookEntity
import com.antelo97.harrypotterapp.data.database.model_entity.CharacterEntity

@Dao
interface CharacterDao {

    @Query("SELECT * FROM Characters")
    suspend fun getCharacters(): List<CharacterEntity>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertCharactersAndWands(characters: List<CharacterEntity>)

    @Query("DELETE FROM Characters")
    suspend fun deleteCharacters()

    @Query("SELECT * FROM Characters WHERE name LIKE '%' || :searchQuery || '%'")
    suspend fun getCharactersByName(searchQuery: String): List<CharacterEntity>
}