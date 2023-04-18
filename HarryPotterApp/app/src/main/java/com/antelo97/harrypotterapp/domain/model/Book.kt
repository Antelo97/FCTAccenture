package com.antelo97.harrypotterapp.domain.model

import com.antelo97.harrypotterapp.data.database.model_entity.BookEntity
import com.antelo97.harrypotterapp.data.network.model_response.BookResponse

data class Book(
    val title: String,
    val imageUrl: String,
    val author: String,
    val releaseDate: String
)

fun BookResponse.toDomain() = Book(title, imageUrl, author = artists[0].author.name, releaseDate)

fun BookEntity.toDomain() = Book(title, imageUrl, author, releaseDate)