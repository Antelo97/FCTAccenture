package com.antelo97.harrypotterapp.di

import com.antelo97.harrypotterapp.data.network.api.BookApiClient
import com.antelo97.harrypotterapp.data.network.api.CharacterApiClient
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

    // https://legacy--api.herokuapp.com/api/v1
    // https://hp-api.onrender.com/

    @Singleton
    @Provides
    @Named("firstApi")
    fun provideRetrofitForFirstApi(): Retrofit {
        return Retrofit
            .Builder()
            .baseUrl("https://legacy--api.herokuapp.com/api/v1/")
            .addConverterFactory(GsonConverterFactory.create())
            .build()
    }

    @Singleton
    @Provides
    @Named("secondApi")
    fun provideRetrofitForSecondApi(): Retrofit {
        return Retrofit
            .Builder()
            .baseUrl("https://hp-api.onrender.com/api/")
            .addConverterFactory(GsonConverterFactory.create())
            .build()
    }

    @Singleton
    @Provides
    fun provideBookApiClient(@Named("firstApi") retrofit: Retrofit): BookApiClient {
        return retrofit.create(BookApiClient::class.java)
    }

    @Singleton
    @Provides
    fun provideCharacterApiClient(@Named("secondApi") retrofit: Retrofit): CharacterApiClient {
        return retrofit.create(CharacterApiClient::class.java)
    }
}