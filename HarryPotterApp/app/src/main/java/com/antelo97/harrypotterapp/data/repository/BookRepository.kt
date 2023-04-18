package com.antelo97.harrypotterapp.data.repository

import com.antelo97.harrypotterapp.data.database.dao.BookDao
import com.antelo97.harrypotterapp.data.database.model_entity.BookEntity
import com.antelo97.harrypotterapp.data.database.model_entity.toDatabase
import com.antelo97.harrypotterapp.data.network.api.BookService
import com.antelo97.harrypotterapp.data.network.model_response.BookResponse
import com.antelo97.harrypotterapp.domain.model.Book
import com.antelo97.harrypotterapp.domain.model.toDomain
import javax.inject.Inject

class BookRepository @Inject constructor(
    private val api: BookService,
    private val dao: BookDao
) {

    suspend fun getAllBooksFromApi(): List<Book>? {
        val response: List<BookResponse> = api.getAllBooks()

        return if (response.isNotEmpty()) {
            deleteAllBooks()
            insertAllBooks(response.map { it.toDatabase() })
            response.map { it.toDomain() }
        } else {
            getAllBooksFromDatabase()
        }
    }

    suspend fun getAllBooksFromDatabase(): List<Book> {
        val query: List<BookEntity> = dao.getAllBooks()
        return query.map { it.toDomain() }
    }

    suspend fun insertAllBooks(books: List<BookEntity>) {
        dao.insertAllBooks(books)
    }

    suspend fun deleteAllBooks() {
        dao.deleteAllBooks()
    }

}