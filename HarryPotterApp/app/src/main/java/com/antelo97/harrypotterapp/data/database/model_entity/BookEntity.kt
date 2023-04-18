package com.antelo97.harrypotterapp.data.database.model_entity

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey
import com.antelo97.harrypotterapp.data.network.model_response.BookResponse
import com.antelo97.harrypotterapp.domain.model.Book
import com.google.gson.annotations.SerializedName

@Entity(tableName = "Books")
data class BookEntity(
    @PrimaryKey(autoGenerate = true)
    @ColumnInfo(name = "id_book") val idBook: Int = 0,
    @ColumnInfo(name = "id_api") val idApi: Int,
    @ColumnInfo(name = "title") val title: String,
    @ColumnInfo(name = "image_url") val imageUrl: String,
    @ColumnInfo(name = "author") val author: String,
    @ColumnInfo(name = "release_date") val releaseDate: String
)

fun BookResponse.toDatabase() = BookEntity(
    idApi = idApi,
    title = title,
    imageUrl = imageUrl,
    author = artists[0].author.name,
    releaseDate = releaseDate
)