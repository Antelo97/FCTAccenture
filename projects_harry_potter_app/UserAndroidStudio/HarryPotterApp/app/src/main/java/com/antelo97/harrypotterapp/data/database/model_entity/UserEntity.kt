package com.antelo97.harrypotterapp.data.database.model_entity

import androidx.room.*
import com.antelo97.harrypotterapp.data.database.model_entity.relations.UserBookCrossRef
import com.antelo97.harrypotterapp.data.database.model_entity.relations.UserCharacterCrossRef
import com.antelo97.harrypotterapp.data.database.model_entity.relations.UserSpeciesCrossRef
import com.antelo97.harrypotterapp.data.database.model_entity.relations.UserSpellsCrossRef
import com.antelo97.harrypotterapp.data.network.model_response.BookResponse
import com.antelo97.harrypotterapp.domain.model.Book
import com.antelo97.harrypotterapp.domain.model.User

@Entity(tableName = "Users")
data class UserEntity(
    @PrimaryKey(autoGenerate = false)
    @ColumnInfo(name = "id_user") val idUser: String,
    @ColumnInfo(name = "email") val email: String,
)

fun User.toDatabase() = UserEntity(
    getIdUser(),
    getEmail(),
)


