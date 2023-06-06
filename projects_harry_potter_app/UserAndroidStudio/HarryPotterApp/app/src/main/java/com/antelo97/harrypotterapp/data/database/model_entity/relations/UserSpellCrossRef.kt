package com.antelo97.harrypotterapp.data.database.model_entity.relations

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.ForeignKey
import com.antelo97.harrypotterapp.data.database.model_entity.*

@Entity(
    tableName = "UserSpellsCrossRef",
    primaryKeys = ["id_user", "id_api_spell"],
)
data class UserSpellsCrossRef(
    @ColumnInfo(name = "id_user") val userId: Int,
    @ColumnInfo(name = "id_api_spell") val bookId: Int
)