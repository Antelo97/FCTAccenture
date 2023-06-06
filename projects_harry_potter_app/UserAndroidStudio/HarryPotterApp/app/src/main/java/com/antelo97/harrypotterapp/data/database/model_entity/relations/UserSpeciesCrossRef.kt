package com.antelo97.harrypotterapp.data.database.model_entity.relations

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.ForeignKey
import com.antelo97.harrypotterapp.data.database.model_entity.BookEntity
import com.antelo97.harrypotterapp.data.database.model_entity.CharacterEntity
import com.antelo97.harrypotterapp.data.database.model_entity.SpeciesEntity
import com.antelo97.harrypotterapp.data.database.model_entity.UserEntity

@Entity(
    tableName = "UserSpeciesCrossRef",
    primaryKeys = ["id_user", "id_api_species"],
)
data class UserSpeciesCrossRef(
    @ColumnInfo(name = "id_user") val userId: Int,
    @ColumnInfo(name = "id_api_species") val bookId: Int
)