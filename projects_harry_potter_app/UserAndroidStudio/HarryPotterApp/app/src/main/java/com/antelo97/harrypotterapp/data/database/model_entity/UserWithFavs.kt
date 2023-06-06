package com.antelo97.harrypotterapp.data.database.model_entity

import androidx.room.Embedded
import androidx.room.Entity
import androidx.room.Junction
import androidx.room.Relation
import com.antelo97.harrypotterapp.data.database.model_entity.*
import com.antelo97.harrypotterapp.data.database.model_entity.relations.UserBookCrossRef
import com.antelo97.harrypotterapp.data.database.model_entity.relations.UserCharacterCrossRef
import com.antelo97.harrypotterapp.data.database.model_entity.relations.UserSpeciesCrossRef
import com.antelo97.harrypotterapp.data.database.model_entity.relations.UserSpellsCrossRef
import com.antelo97.harrypotterapp.domain.model.User
import com.antelo97.harrypotterapp.domain.model.toDomain

data class UserWithFavs(
    // Embedded significa que incorpora todos los atributos de dicha clase
    // (en este caso incorporaría idUser y email que son los atributos de UserEntity)
    @Embedded val user: UserEntity,
    @Relation(
        parentColumn = "id_user",
        entityColumn = "id_api_book",
        associateBy = Junction(UserBookCrossRef::class)
    )
    val favBooks: List<BookEntity>,

    @Relation(
        parentColumn = "id_user",
        entityColumn = "id_api_character",
        associateBy = Junction(UserCharacterCrossRef::class)
    )
    val favCharacters: List<CharacterEntity>,

    @Relation(
        parentColumn = "id_user",
        entityColumn = "id_api_spell",
        associateBy = Junction(UserSpellsCrossRef::class)
    )
    val favSpells: List<SpellEntity>,

    @Relation(
        parentColumn = "id_user",
        entityColumn = "id_api_species",
        associateBy = Junction(UserSpeciesCrossRef::class)
    )
    val favSpecies: List<SpeciesEntity>
)


/*fun User.toDatabase() = com.antelo97.harrypotterapp.data.database.model_entity.UserWithFavs(
    user = UserEntity(idUser = getIdUser(), email = getEmail()),
    favBooks = favBooks.map { it.toDatabase() },
    favCharacters = favCharacters.map { it.toDatabase() },
    favSpells = favSpells.map { it.toDatabase() },
    favSpecies = favSpecies.map { it.toDatabase() },
)*/
