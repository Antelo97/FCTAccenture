package com.antelo97.harrypotterapp.domain.model

import com.antelo97.harrypotterapp.data.database.model_entity.BookEntity

data class Book(
    val idApiBook: Int,
    var title: String,
    val imageUrl: String,
    val author: String,
    val releaseDate: String,
    val isFavorite: Boolean
)

fun BookEntity.toDomain() = Book(idApiBook, title, imageUrl, author, releaseDate, isFavorite)