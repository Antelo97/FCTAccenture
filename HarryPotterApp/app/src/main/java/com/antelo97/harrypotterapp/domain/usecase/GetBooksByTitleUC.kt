package com.antelo97.harrypotterapp.domain.usecase

import com.antelo97.harrypotterapp.data.repository.BookRepository
import com.antelo97.harrypotterapp.domain.model.Book
import javax.inject.Inject

class GetBooksByTitleUC @Inject constructor(private val repository: BookRepository) {

    suspend operator fun invoke(searchQuery: String): List<Book> {
        return repository.getBooksByTitle(searchQuery)
    }
}