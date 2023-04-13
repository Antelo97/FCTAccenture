package com.antelo97.examplemvvm.data

import com.antelo97.examplemvvm.data.model.QuoteModel
import com.antelo97.examplemvvm.data.model.QuoteProvider
import com.antelo97.examplemvvm.data.network.QuoteService

class QuoteRepository {
    private val api = QuoteService()

    suspend fun getAllQuotes(): List<QuoteModel> {
        val response: List<QuoteModel> = api.getQuotes()
        QuoteProvider.quotes = response
        return response
    }
}