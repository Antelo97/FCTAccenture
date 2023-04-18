package com.antelo97.harrypotterapp.data.database

import androidx.room.Database
import androidx.room.RoomDatabase
import com.antelo97.harrypotterapp.data.database.dao.BookDao
import com.antelo97.harrypotterapp.data.database.model_entity.BookEntity

@Database(entities = [BookEntity::class], version = 1)
abstract class HarryPotterDatabase : RoomDatabase() {

    abstract fun getBookDao(): BookDao
}