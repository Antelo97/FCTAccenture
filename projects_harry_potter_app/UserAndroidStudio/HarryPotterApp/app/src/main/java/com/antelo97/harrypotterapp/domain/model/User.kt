package com.antelo97.harrypotterapp.domain.model

import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.FirebaseUser

data class User(
    private val idUser: String,
    private val email: String,
    var favBooks: List<Book> = emptyList(),
    var favCharacters: List<com.antelo97.harrypotterapp.domain.model.Character> = emptyList(),
    var favSpells: List<Spell> = emptyList(),
    var favSpecies: List<Species> = emptyList(),
) {
    fun getIdUser(): String {
        return idUser
    }

    fun getEmail(): String {
        return email
    }

    companion object {
        private var uidAppUser: String? = null

        fun initializeAppUser() {
            uidAppUser = FirebaseAuth.getInstance().currentUser!!.uid;
        }

        fun getUidAppUser(): String {
            return uidAppUser ?: throw IllegalStateException("User instance has not been initialized.")
        }
    }
}

fun com.antelo97.harrypotterapp.data.database.model_entity.UserWithFavs.toDomain() = User(
    user.idUser,
    user.email,
    favBooks.map { it.toDomain() },
    favCharacters.map { it.toDomain() },
    favSpells.map { it.toDomain() },
    favSpecies.map { it.toDomain() }
)

fun FirebaseUser.toDomain() = User(idUser = uid, email = email!!)

