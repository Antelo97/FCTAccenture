package com.antelo97.examplemvvm.domain

import com.antelo97.examplemvvm.data.model.QuoteModel
import com.antelo97.examplemvvm.data.model.QuoteProvider
import javax.inject.Inject

class GetRandomQuoteUseCase @Inject constructor(private val quoteProvider: QuoteProvider) {
    operator fun invoke(): QuoteModel? {
        val quotes: List<QuoteModel> = quoteProvider.quotes
        if (!quotes.isNullOrEmpty()) {
            val position = (quotes.indices).random()
            return quotes[position]
        }
        return null
    }
}