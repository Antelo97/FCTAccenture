package com.antelo97.harrypotterapp.data.database.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.antelo97.harrypotterapp.data.database.model_entity.BookEntity

@Dao
interface BookDao {

    @Query("SELECT * FROM Books")
    suspend fun getAllBooks(): List<BookEntity>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertAllBooks(books: List<BookEntity>)

    @Query("DELETE FROM Books")
    suspend fun deleteAllBooks()
}