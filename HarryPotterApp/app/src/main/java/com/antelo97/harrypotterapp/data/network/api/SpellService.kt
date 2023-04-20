package com.antelo97.harrypotterapp.data.network.api

import com.antelo97.harrypotterapp.data.network.model_response.CharacterResponse
import com.antelo97.harrypotterapp.data.network.model_response.SpellResponse
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import javax.inject.Inject

class SpellService @Inject constructor(private val api: SpellApiClient) {

    suspend fun getAllSpells(): List<SpellResponse> {
        return withContext(Dispatchers.IO) {
            api.getAllSpells().body().orEmpty()
        }
    }
}