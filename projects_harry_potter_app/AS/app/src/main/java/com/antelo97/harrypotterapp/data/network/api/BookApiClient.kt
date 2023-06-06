package com.antelo97.harrypotterapp.data.network.api

import com.antelo97.harrypotterapp.data.network.model_response.BookResponse
import retrofit2.Response
import retrofit2.http.GET

interface BookApiClient {

    @GET("books")
    suspend fun getAllBooks(): Response<List<BookResponse>>
}