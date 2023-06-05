package com.antelo97.harrypotterapp.data.network.model_response

import com.google.gson.annotations.SerializedName

data class SpeciesResponse(
    @SerializedName("id") val idApi: Int,
    @SerializedName("name") val name: String,
    @SerializedName("native") val native_: String
)