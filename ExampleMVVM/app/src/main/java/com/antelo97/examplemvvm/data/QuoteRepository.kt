package com.antelo97.examplemvvm.data

import com.antelo97.examplemvvm.data.model.QuoteModel
import com.antelo97.examplemvvm.data.model.QuoteProvider
import com.antelo97.examplemvvm.data.network.QuoteService
import javax.inject.Inject

class QuoteRepository @Inject constructor(
    private val api: QuoteService,
    private val quoteProvider: QuoteProvider
) {

    // private val api = QuoteService()

    suspend fun getAllQuotes(): List<QuoteModel> {
        val response: List<QuoteModel> = api.getQuotes()
        quoteProvider.quotes = response
        return response
    }
}