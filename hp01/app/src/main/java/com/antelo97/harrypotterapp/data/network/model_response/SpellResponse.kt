package com.antelo97.harrypotterapp.data.network.model_response

import com.google.gson.annotations.SerializedName

data class SpellResponse(
    @SerializedName("id") val idApi: String,
    @SerializedName("name") val name: String,
    @SerializedName("description") val description: String
)