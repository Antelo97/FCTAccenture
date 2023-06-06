package com.antelo97.harrypotterapp.domain.usecase

import com.antelo97.harrypotterapp.data.repository.BookRepository
import com.antelo97.harrypotterapp.domain.model.Book
import javax.inject.Inject

class GetBooksUC @Inject constructor(private val repository: BookRepository) {

    suspend operator fun invoke(): List<Book> {
        repository.getAllBooksFromApi()
        return repository.getAllBooksFromDatabase()
    }
}