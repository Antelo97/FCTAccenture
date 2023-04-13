package com.antelo97.examplemvvm.domain

import com.antelo97.examplemvvm.data.model.QuoteModel
import com.antelo97.examplemvvm.data.model.QuoteProvider

class GetRandomQuoteUseCase {
    operator fun invoke(): QuoteModel? {
        val quotes: List<QuoteModel> = QuoteProvider.quotes
        if (!quotes.isNullOrEmpty()) {
            val position = (quotes.indices).random()
            return quotes[position]
        }
        return null
    }
}