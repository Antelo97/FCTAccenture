package com.antelo97.harrypotterapp.data.database

import androidx.room.Database
import androidx.room.RoomDatabase
import com.antelo97.harrypotterapp.data.database.dao.*
import com.antelo97.harrypotterapp.data.database.model_entity.*
import com.antelo97.harrypotterapp.data.database.model_entity.relations.UserBookCrossRef
import com.antelo97.harrypotterapp.data.database.model_entity.relations.UserCharacterCrossRef
import com.antelo97.harrypotterapp.data.database.model_entity.relations.UserSpeciesCrossRef
import com.antelo97.harrypotterapp.data.database.model_entity.relations.UserSpellsCrossRef

@Database(
    entities = [BookEntity::class, CharacterEntity::class, WandEntity::class,
        SpellEntity::class, SpeciesEntity::class, UserEntity::class,
        UserBookCrossRef::class, UserCharacterCrossRef::class,
        UserSpellsCrossRef::class, UserSpeciesCrossRef::class],
    version = 2
    // No se si es imprescindible pero al modificar la estructura de la BD, también actualice la versión
)
abstract class HarryPotterDatabase : RoomDatabase() {

    abstract fun getBookDao(): BookDao
    abstract fun getCharacterDao(): CharacterDao
    abstract fun getSpellDao(): SpellDao
    abstract fun getSpeciesDao(): SpeciesDao
    abstract fun getUsersDao(): UserDao
}