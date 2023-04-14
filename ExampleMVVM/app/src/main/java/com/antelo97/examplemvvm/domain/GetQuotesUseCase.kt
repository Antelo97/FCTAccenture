package com.antelo97.examplemvvm.domain

import com.antelo97.examplemvvm.data.QuoteRepository
import com.antelo97.examplemvvm.data.database.entities.toDatabase
import com.antelo97.examplemvvm.data.model.QuoteModel
import com.antelo97.examplemvvm.domain.model.Quote
import javax.inject.Inject

class GetQuotesUseCase @Inject constructor(private val repository: QuoteRepository) {

    // private val repository = QuoteRepository()

    // suspend operator fun invoke(): List<QuoteModel>? = repository.getAllQuotesFromApi()

    suspend operator fun invoke(): List<Quote> {
        val quotes: List<Quote> = repository.getAllQuotesFromApi()

        return if (quotes.isNotEmpty()) {
            repository.clearQuotes()
            repository.insertQuotes(quotes.map { it.toDatabase() })
            quotes
        } else {
            repository.getAllQuotesFromDatabase()
        }
    }
}