package com.antelo97.harrypotterapp.domain.model

import com.antelo97.harrypotterapp.data.database.model_entity.BookEntity

data class Book(
    private val idApiBook: Int,
    private val title: String,
    private val imageUrl: String,
    private val author: String,
    private val releaseDate: String,
    var isFavorite: Boolean
) {
    fun getIdApiBook(): Int {
        return idApiBook
    }

    fun getTitle(): String {
        return title
    }

    fun getImageUrl(): String {
        return imageUrl
    }

    fun getAuthor(): String {
        return author
    }

    fun getReleaseDate(): String {
        return releaseDate
    }
}

fun BookEntity.toDomain() = Book(idApiBook, title, imageUrl, author, releaseDate, isFavorite)