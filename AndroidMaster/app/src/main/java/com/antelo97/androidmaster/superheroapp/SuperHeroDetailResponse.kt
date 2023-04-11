package com.antelo97.androidmaster.superheroapp

import com.google.gson.annotations.SerializedName

data class SuperHeroDetailResponse(
    @SerializedName("name") val name: String,
    @SerializedName("powerstats") val powerstats: PowerstatsResponse,
    @SerializedName("biography") val biography: BiographyResponse,
    @SerializedName("image") val image: SuperheroImageDetailResponse
)

data class PowerstatsResponse(
    @SerializedName("intelligence") val intelligence: String,
    @SerializedName("strength") val strength: String,
    @SerializedName("speed") val speed: String,
    @SerializedName("durability") val durability: String,
    @SerializedName("power") val power: String,
    @SerializedName("combat") val combat: String,
)

data class BiographyResponse(
    @SerializedName("full-name") val fullName: String,
    @SerializedName("publisher") val publisher: String
)

data class SuperheroImageDetailResponse(
    @SerializedName("url") val url: String
)

