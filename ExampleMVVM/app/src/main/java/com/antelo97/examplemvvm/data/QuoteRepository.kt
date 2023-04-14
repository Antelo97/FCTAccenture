package com.antelo97.examplemvvm.data

import com.antelo97.examplemvvm.data.database.dao.QuoteDao
import com.antelo97.examplemvvm.data.database.entities.QuoteEntity
import com.antelo97.examplemvvm.data.model.QuoteModel
import com.antelo97.examplemvvm.data.network.QuoteService
import com.antelo97.examplemvvm.domain.model.Quote
import com.antelo97.examplemvvm.domain.model.toDomain
import javax.inject.Inject

class QuoteRepository @Inject constructor(
    private val api: QuoteService,
    // private val quoteProvider: QuoteProvider
    private val quoteDao: QuoteDao
) {

    // private val api = QuoteService()

    suspend fun getAllQuotesFromApi(): List<Quote> {
        val response: List<QuoteModel> = api.getQuotes()
        //quoteProvider.quotes = response
        return response.map { it.toDomain() }
    }

    suspend fun getAllQuotesFromDatabase(): List<Quote> {
        val response: List<QuoteEntity> = quoteDao.getAllQuotes()
        return response.map { it.toDomain() }
    }

    suspend fun insertQuotes(quotes: List<QuoteEntity>) {
        quoteDao.insertAll(quotes)
    }

    suspend fun clearQuotes() {
        quoteDao.deleteAllQuotes()
    }
}