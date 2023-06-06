package com.antelo97.harrypotterapp.data.database.dao

import com.antelo97.harrypotterapp.data.database.model_entity.UserWithFavs
import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import androidx.room.Transaction
import androidx.room.Update
import com.antelo97.harrypotterapp.data.database.model_entity.UserEntity
import com.antelo97.harrypotterapp.data.database.model_entity.relations.UserBookCrossRef
import com.antelo97.harrypotterapp.data.database.model_entity.relations.UserCharacterCrossRef
import com.antelo97.harrypotterapp.data.database.model_entity.relations.UserSpeciesCrossRef
import com.antelo97.harrypotterapp.data.database.model_entity.relations.UserSpellsCrossRef

@Dao
interface UserDao {

    @Transaction
    @Query("SELECT * FROM Users WHERE id_user = :uid")
    suspend fun getUser(uid: String): UserWithFavs

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertUser(user: UserEntity)

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertFavBook(favBook: UserBookCrossRef)

    @Query("DELETE FROM UserBookCrossRef WHERE id_user = :uid AND id_api_book = :idApiBook")
    suspend fun deleteFavBook(uid: String, idApiBook: Int)

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertFavCharacter(favCharacter: UserCharacterCrossRef)

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertFavSpell(favSpell: UserSpellsCrossRef)

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertFavSpecies(favSpecies: UserSpeciesCrossRef)

    @Query("DELETE FROM Users WHERE id_user = :uid")
    suspend fun deleteUser(uid: String)

    @Update
    suspend fun updateUser(user: UserEntity)
}