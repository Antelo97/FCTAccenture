package com.antelo97.harrypotterapp.di

import android.content.Context
import androidx.room.Room
import com.antelo97.harrypotterapp.data.database.HarryPotterDatabase
import com.antelo97.harrypotterapp.data.database.dao.BookDao
import com.antelo97.harrypotterapp.data.database.dao.CharacterDao
import com.antelo97.harrypotterapp.data.database.dao.SpeciesDao
import com.antelo97.harrypotterapp.data.database.dao.SpellDao
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object RoomModule {

    private const val DATABASE_NAME = "HarryPotterDB"

    @Singleton
    @Provides
    fun provideRoom(@ApplicationContext context: Context) =
        Room.databaseBuilder(context, HarryPotterDatabase::class.java, DATABASE_NAME).build()

    @Singleton
    @Provides
    fun provideBookDao(db: HarryPotterDatabase): BookDao = db.getBookDao()

    @Singleton
    @Provides
    fun provideCharacterDao(db: HarryPotterDatabase): CharacterDao = db.getCharacterDao()

    @Singleton
    @Provides
    fun provideSpellDao(db: HarryPotterDatabase): SpellDao = db.getSpellDao()

    @Singleton
    @Provides
    fun provideSpeciesDao(db: HarryPotterDatabase): SpeciesDao = db.getSpeciesDao()
}