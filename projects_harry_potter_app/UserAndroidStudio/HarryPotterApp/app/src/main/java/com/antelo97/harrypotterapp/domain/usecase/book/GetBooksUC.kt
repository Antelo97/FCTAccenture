package com.antelo97.harrypotterapp.domain.usecase.book

import com.antelo97.harrypotterapp.data.repository.BookRepository
import com.antelo97.harrypotterapp.domain.model.Book
import javax.inject.Inject

class GetBooksUC @Inject constructor(private val repository: BookRepository) {

    suspend operator fun invoke(): List<Book> {
        val query: List<Book> = repository.getBooksFromDatabase()

        return if (query.isEmpty()) {
            repository.insertBooks()
            repository.getBooksFromDatabase()
        } else {
            query
        }
    }
}