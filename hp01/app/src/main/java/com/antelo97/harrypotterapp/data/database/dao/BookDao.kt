package com.antelo97.harrypotterapp.data.database.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import androidx.room.Update
import com.antelo97.harrypotterapp.data.database.model_entity.BookEntity
import com.antelo97.harrypotterapp.domain.model.Book

@Dao
interface BookDao {

    @Query("SELECT * FROM Books")
    suspend fun getBooks(): List<BookEntity>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertBooks(books: List<BookEntity>)

    @Query("DELETE FROM Books")
    suspend fun deleteAllBooks()

    @Query("SELECT * FROM Books WHERE title LIKE '%' || :searchQuery || '%'")
    suspend fun getBooksByTitle(searchQuery: String): List<BookEntity>

    @Update
    suspend fun updateBook(book: BookEntity)

    @Query("SELECT * FROM Books WHERE is_favorite = 1")
    suspend fun getFavoriteBooks(): List<BookEntity>
}