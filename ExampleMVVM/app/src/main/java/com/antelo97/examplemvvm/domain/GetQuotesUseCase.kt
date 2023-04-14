package com.antelo97.examplemvvm.domain

import com.antelo97.examplemvvm.data.QuoteRepository
import com.antelo97.examplemvvm.data.model.QuoteModel
import javax.inject.Inject

class GetQuotesUseCase @Inject constructor(private val repository: QuoteRepository) {

    // private val repository = QuoteRepository()

    suspend operator fun invoke(): List<QuoteModel>? = repository.getAllQuotes()
}