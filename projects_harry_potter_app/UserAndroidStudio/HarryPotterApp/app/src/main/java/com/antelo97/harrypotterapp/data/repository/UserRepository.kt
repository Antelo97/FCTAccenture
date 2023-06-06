package com.antelo97.harrypotterapp.data.repository

import com.antelo97.harrypotterapp.data.database.dao.UserDao
import com.antelo97.harrypotterapp.data.database.model_entity.relations.UserBookCrossRef
import com.antelo97.harrypotterapp.data.database.model_entity.toDatabase
import com.antelo97.harrypotterapp.domain.model.*
import javax.inject.Inject

class UserRepository @Inject constructor(
    private val dao: UserDao
) {

    suspend fun getUserFromDatabase(uid: String): User {
        val query: com.antelo97.harrypotterapp.data.database.model_entity.UserWithFavs = dao.getUser(uid)
        return query.toDomain()
    }

    suspend fun insertUser(user: User) {
        dao.insertUser(user.toDatabase())
    }

    suspend fun insertFavBook(uid: String, idApiBook: Int){
        val userBookCrossRef = UserBookCrossRef(uid, idApiBook)
        dao.insertFavBook(userBookCrossRef)
    }

    suspend fun deleteFavBook(uid: String, idApiBook: Int){
        dao.deleteFavBook(uid, idApiBook)
    }

    suspend fun deleteUser(uid: String) {
        dao.deleteUser(uid)
    }

    suspend fun updateUser(user: User) {
        dao.updateUser(user.toDatabase())
    }

    suspend fun getFavoriteBooks(uid: String): List<Book> {
        return getUserFromDatabase(uid).favBooks
    }

    suspend fun getFavoriteCharacters(uid: String): List<com.antelo97.harrypotterapp.domain.model.Character> {
        return getUserFromDatabase(uid).favCharacters
    }

    suspend fun getFavoriteSpells(uid: String): List<Spell> {
        return getUserFromDatabase(uid).favSpells
    }

    suspend fun getFavoriteSpecies(uid: String): List<Species> {
        return getUserFromDatabase(uid).favSpecies
    }
}