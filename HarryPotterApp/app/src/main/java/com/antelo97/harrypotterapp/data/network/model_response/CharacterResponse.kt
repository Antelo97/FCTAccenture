package com.antelo97.harrypotterapp.data.network.model_response

import com.google.gson.annotations.SerializedName

data class CharacterResponse(
    @SerializedName("id") val idApi: String,
    @SerializedName("name") val name: String,
    @SerializedName("species") val species: String,
    @SerializedName("gender") val gender: String,
    @SerializedName("house") val house: String,
    @SerializedName("yearOfBirth") val yearOfBirth: Int,
    @SerializedName("wizard") val isWizard: Boolean,
    @SerializedName("ancestry") val ancestry: String,
    @SerializedName("wand") val wand: WandResponse,
    @SerializedName("patronus") val patronus: String,
    @SerializedName("hogwartsStudent") val isHogwartsStudent: Boolean,
    @SerializedName("hogwartsStaff") val isHogwartsStaff: Boolean,
    @SerializedName("actor") val actor: String,
    @SerializedName("alive") val isAlive: Boolean,
    @SerializedName("image") val imageUrl: String
)

data class WandResponse(
    @SerializedName("wood") val wood: String,
    @SerializedName("core") val core: String,
    @SerializedName("length") val length: Double
)