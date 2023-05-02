package com.antelo97.harrypotterapp.data.network.api

import com.antelo97.harrypotterapp.data.network.model_response.SpeciesResponse
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import javax.inject.Inject

class SpeciesService @Inject constructor(private val api: SpeciesApiClient) {

    suspend fun getSpecies(): List<SpeciesResponse> {
        return withContext(Dispatchers.IO) {
            api.getAllSpecies().body().orEmpty()
        }
    }
}