package com.antelo97.harrypotterapp.domain.usecase

import com.antelo97.harrypotterapp.data.repository.BookRepository
import com.antelo97.harrypotterapp.domain.model.Book
import javax.inject.Inject

class GetFavoriteBooksUC @Inject constructor(private val repository: BookRepository) {

    suspend operator fun invoke(): List<Book> {
        return repository.getFavoriteBooks()
    }
}