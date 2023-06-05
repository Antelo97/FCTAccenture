package com.antelo97.harrypotterapp.data.network.model_response

import com.google.gson.annotations.SerializedName

data class BookResponse(
    @SerializedName("id") val idApi: Int,
    @SerializedName("title") val title: String,
    @SerializedName("image_url") val imageUrl: String,
    @SerializedName("artists") val artists: List<ArtistResponse>,
    @SerializedName("release_date") val releaseDate: String
)

data class ArtistResponse(
    @SerializedName("author") val author: AuthorResponse
)

data class AuthorResponse(
    @SerializedName("id") val idApi: Int,
    @SerializedName("name") val name: String
)