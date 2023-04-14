package com.antelo97.examplemvvm.domain.model

import com.antelo97.examplemvvm.data.database.entities.QuoteEntity
import com.antelo97.examplemvvm.data.model.QuoteModel

data class Quote(
    val quote: String,
    val author: String
)

fun QuoteModel.toDomain() = Quote(quote, author)
fun QuoteEntity.toDomain() = Quote(quote, author)