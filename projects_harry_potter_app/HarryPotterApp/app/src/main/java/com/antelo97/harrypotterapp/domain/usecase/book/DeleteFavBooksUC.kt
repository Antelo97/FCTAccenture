package com.antelo97.harrypotterapp.domain.usecase.book

import com.antelo97.harrypotterapp.data.repository.BookRepository
import com.antelo97.harrypotterapp.domain.model.Book
import javax.inject.Inject

class DeleteFavBooksUC @Inject constructor(private val repository: BookRepository) {

    suspend operator fun invoke() {
        val noFavBooks: List<Book> = repository.getBooksFromDatabase().map { book ->
            book.copy(isFavorite = false)
        }
        repository.updateBooks(noFavBooks)
    }
}