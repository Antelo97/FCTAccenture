package com.antelo97.harrypotterapp.data.network.api

import com.antelo97.harrypotterapp.data.network.model_response.SpeciesResponse
import retrofit2.Response
import retrofit2.http.GET

interface SpeciesApiClient {

    @GET("species")
    suspend fun getAllSpecies(): Response<List<SpeciesResponse>>
}