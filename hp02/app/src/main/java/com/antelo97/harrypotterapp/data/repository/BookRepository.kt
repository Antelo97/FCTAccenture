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

    suspend fun getBooksFromApi(): List<Book> {
        val response: List<BookResponse> = api.getBooks()

        return if (response.isNotEmpty()) {
            deleteBooks()
            insertBooks()
            response.map { it.toDatabase().toDomain() }
        } else {
            getBooksFromDatabase()
        }
    }

    suspend fun getBooksFromDatabase(): List<Book> {
        val query: List<BookEntity> = dao.getBooks()
        return query.map { it.toDomain() }
    }

    suspend fun insertBooks() {
        val books: List<BookEntity> = api.getBooks().map { it.toDatabase() }

        deleteBooks()
        dao.insertBooks(books)
    }

    suspend fun deleteBooks() {
        dao.deleteAllBooks()
    }

    suspend fun getBooksByTitle(searchQuery: String): List<Book> {
        return dao.getBooksByTitle(searchQuery).map { it.toDomain() }
    }

    suspend fun updateBook(book: Book) {
        dao.updateBook(book.toDatabase())
    }

    suspend fun getFavoriteBooks(): List<Book> {
        return dao.getFavoriteBooks().map { it.toDomain() }
    }
}