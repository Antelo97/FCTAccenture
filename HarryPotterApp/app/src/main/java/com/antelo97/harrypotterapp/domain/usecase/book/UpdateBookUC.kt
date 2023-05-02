package com.antelo97.harrypotterapp.domain.usecase.book

import com.antelo97.harrypotterapp.data.repository.BookRepository
import com.antelo97.harrypotterapp.domain.model.Book
import javax.inject.Inject

class UpdateBookUC @Inject constructor(private val repository: BookRepository) {

    suspend operator fun invoke(book: Book) {
        repository.updateBook(book)
    }
}