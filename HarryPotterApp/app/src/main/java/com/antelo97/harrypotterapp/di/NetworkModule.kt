package com.antelo97.harrypotterapp.di

import com.antelo97.harrypotterapp.data.network.api.BookApiClient
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import javax.inject.Named
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object NetworkModule {
    @Singleton
    @Provides
    @Named("firstApiRetrofit")
    fun provideRetrofitForMainApi(): Retrofit {
        return Retrofit
            .Builder()
            .baseUrl("https://legacy--api.herokuapp.com/api/v1/")
            .addConverterFactory(GsonConverterFactory.create())
            .build()
    }

    @Singleton
    @Provides
    @Named("secondApiRetrofit")
    fun provideRetrofitForSpellApi(): Retrofit {
        return Retrofit
            .Builder()
            .baseUrl("https://hp-api.onrender.com/api/")
            .addConverterFactory(GsonConverterFactory.create())
            .build()
    }

    @Singleton
    @Provides
    fun provideBookApiClient(@Named("firstApiRetrofit") retrofit: Retrofit): BookApiClient {
        return retrofit.create(BookApiClient::class.java)
    }
}