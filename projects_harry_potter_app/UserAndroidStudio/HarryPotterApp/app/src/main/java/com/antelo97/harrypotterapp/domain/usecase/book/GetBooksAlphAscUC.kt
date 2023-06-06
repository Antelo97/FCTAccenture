package com.antelo97.harrypotterapp.domain.usecase.book

import com.antelo97.harrypotterapp.domain.model.Book
import javax.inject.Inject

class GetBooksAlphAscUC @Inject constructor() {

    operator fun invoke(foundBooks: List<Book>): List<Book> = foundBooks.sortedBy { it.getTitle() }
}