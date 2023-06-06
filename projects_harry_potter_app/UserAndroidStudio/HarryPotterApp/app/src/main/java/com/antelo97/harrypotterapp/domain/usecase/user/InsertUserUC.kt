package com.antelo97.harrypotterapp.domain.usecase.book

import com.antelo97.harrypotterapp.data.repository.BookRepository
import com.antelo97.harrypotterapp.data.repository.UserRepository
import com.antelo97.harrypotterapp.domain.model.Book
import com.antelo97.harrypotterapp.domain.model.User
import com.antelo97.harrypotterapp.domain.model.toDomain
import com.google.firebase.auth.FirebaseUser
import javax.inject.Inject

class InsertUserUC @Inject constructor(private val repository: UserRepository) {

    suspend operator fun invoke(user: FirebaseUser): User {
        repository.insertUser(user.toDomain())
        return repository.getUserFromDatabase(user.uid)
    }
}