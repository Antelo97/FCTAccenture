package com.antelo97.harrypotterapp.data.network.api

import com.antelo97.harrypotterapp.data.network.model_response.CharacterResponse
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import javax.inject.Inject

class CharacterService @Inject constructor(private val api: CharacterApiClient) {

    suspend fun getAllCharacters(): List<CharacterResponse> {
        return withContext(Dispatchers.IO) {
            api.getAllCharacters().body().orEmpty()
        }
    }
}
