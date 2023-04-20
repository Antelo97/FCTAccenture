package com.antelo97.harrypotterapp.data.network.api

import com.antelo97.harrypotterapp.data.network.model_response.CharacterResponse
import retrofit2.Response
import retrofit2.http.GET

interface CharacterApiClient {

    @GET("characters")
    suspend fun getAllCharacters(): Response<List<CharacterResponse>>
}