package com.antelo97.harrypotterapp.data.database

import androidx.room.Database
import androidx.room.RoomDatabase
import com.antelo97.harrypotterapp.data.database.dao.BookDao
import com.antelo97.harrypotterapp.data.database.dao.CharacterDao
import com.antelo97.harrypotterapp.data.database.model_entity.BookEntity
import com.antelo97.harrypotterapp.data.database.model_entity.CharacterEntity

@Database(entities = [BookEntity::class, CharacterEntity::class, WandEntity::class], version = 1)
abstract class HarryPotterDatabase : RoomDatabase() {

    abstract fun getBookDao(): BookDao
    abstract fun getCharacterDao(): CharacterDao
}