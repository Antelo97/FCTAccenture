package com.antelo97.harrypotterapp.data.network.api

import com.antelo97.harrypotterapp.data.network.model_response.SpellResponse
import retrofit2.Response
import retrofit2.http.GET

interface SpellApiClient {

    @GET("spells")
    suspend fun getAllSpells(): Response<List<SpellResponse>>
}