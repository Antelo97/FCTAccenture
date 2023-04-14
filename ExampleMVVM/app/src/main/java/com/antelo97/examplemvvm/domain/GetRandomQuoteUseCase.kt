package com.antelo97.examplemvvm.domain

import com.antelo97.examplemvvm.data.QuoteRepository
import com.antelo97.examplemvvm.data.database.entities.QuoteEntity
import com.antelo97.examplemvvm.data.model.QuoteModel
import com.antelo97.examplemvvm.data.model.QuoteProvider
import com.antelo97.examplemvvm.domain.model.Quote
import javax.inject.Inject

class GetRandomQuoteUseCase @Inject constructor(private val repository: QuoteRepository) {
    suspend operator fun invoke(): Quote? {
        val quotes: List<Quote> = repository.getAllQuotesFromDatabase()
        if (!quotes.isNullOrEmpty()) {
            val position = (quotes.indices).random()
            return quotes[position]
        }
        return null
    }
}