package com.antelo97.harrypotterapp.data.database.dao

import androidx.room.*
import com.antelo97.harrypotterapp.data.database.model_entity.BookEntity
import com.antelo97.harrypotterapp.data.database.model_entity.SpellEntity

@Dao
interface SpellDao {

    @Query("SELECT * FROM Spells")
    suspend fun getSpells(): List<SpellEntity>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertSpells(characters: List<SpellEntity>)

    @Query("DELETE FROM Spells")
    suspend fun deleteSpells()

    @Query("SELECT * FROM Spells WHERE name LIKE '%' || :searchQuery || '%'")
    suspend fun getSpellsByName(searchQuery: String): List<SpellEntity>

    @Update
    suspend fun updateSpell(spell: SpellEntity)

    @Update
    suspend fun updateSpells(spells: List<SpellEntity>)

    @Query("SELECT * FROM Spells WHERE is_favorite = 1")
    suspend fun getFavoriteSpells(): List<SpellEntity>
}