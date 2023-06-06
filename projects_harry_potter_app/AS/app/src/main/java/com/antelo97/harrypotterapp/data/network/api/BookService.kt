package com.antelo97.harrypotterapp.data.network.api

import com.antelo97.harrypotterapp.data.network.model_response.BookResponse
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import retrofit2.Response
import javax.inject.Inject

class BookService @Inject constructor(private val api: BookApiClient) {

    suspend fun getAllBooks(): List<BookResponse> {
        return withContext(Dispatchers.IO) {
            val response: Response<List<BookResponse>> = api.getAllBooks()
            response.body().orEmpty()
        }
    }
}