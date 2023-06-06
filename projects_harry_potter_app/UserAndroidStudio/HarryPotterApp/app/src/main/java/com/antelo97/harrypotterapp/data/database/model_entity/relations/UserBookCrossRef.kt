package com.antelo97.harrypotterapp.data.database.model_entity.relations

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.ForeignKey
import com.antelo97.harrypotterapp.data.database.model_entity.BookEntity
import com.antelo97.harrypotterapp.data.database.model_entity.UserEntity

@Entity(
    tableName = "UserBookCrossRef",
    primaryKeys = ["id_user", "id_api_book"],
)
data class UserBookCrossRef(
    @ColumnInfo(name = "id_user") val idUser: String,
    @ColumnInfo(name = "id_api_book") val idApiBook: Int
)