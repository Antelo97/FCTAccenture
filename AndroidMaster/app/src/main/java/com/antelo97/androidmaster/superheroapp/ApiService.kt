package com.antelo97.androidmaster.superheroapp

import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.Path

interface ApiService {

    @GET("api/1389253905244111/search/{name}")
    suspend fun getSuperHeroes(@Path("name") superHeroName: String): Response<SuperHeroDataResponse>

    @GET("api/1389253905244111/{id}")
    suspend fun getSuperHeroDetail(@Path("id") superHeroId: String): Response<SuperHeroDetailResponse>
}