package com.antelo97.harrypotterapp.domain.usecase.book

import com.antelo97.harrypotterapp.data.repository.BookRepository
import com.antelo97.harrypotterapp.domain.model.Book
import javax.inject.Inject

class GetBooksAlphDescUC @Inject constructor() {

    operator fun invoke(foundBooks: List<Book>) = foundBooks.sortedByDescending { it.title }
}