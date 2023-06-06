package com.antelo97.harrypotterapp.data.database.model_entity

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey
import com.antelo97.harrypotterapp.data.network.model_response.BookResponse
import com.antelo97.harrypotterapp.domain.model.Book

@Entity(tableName = "Books")
data class BookEntity(
    @PrimaryKey(autoGenerate = false)
    @ColumnInfo(name = "id_api_book") val idApiBook: Int,
    @ColumnInfo(name = "title") val title: String,
    @ColumnInfo(name = "image_url") val imageUrl: String,
    @ColumnInfo(name = "author") val author: String,
    @ColumnInfo(name = "release_date") val releaseDate: String,
    @ColumnInfo(name = "is_favorite") val isFavorite: Boolean = false
)

fun BookResponse.toDatabase() = BookEntity(
    idApiBook = idApi,
    title = title,
    imageUrl = imageUrl,
    author = artists[0].author.name,
    releaseDate = releaseDate,
)

fun Book.toDatabase() = BookEntity(
    getIdApiBook(),
    getTitle(),
    getImageUrl(),
    getAuthor(),
    getReleaseDate(),
    isFavorite
)