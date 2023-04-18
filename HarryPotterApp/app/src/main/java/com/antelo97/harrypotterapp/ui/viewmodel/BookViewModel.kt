package com.antelo97.harrypotterapp.ui.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.antelo97.harrypotterapp.domain.model.Book
import com.antelo97.harrypotterapp.domain.usecase.GetBooksUC
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class BookViewModel @Inject constructor(
    private val getBooksUC: GetBooksUC
) : ViewModel() {

    val book: MutableLiveData<Book> = MutableLiveData<Book>()

    fun onCreate() {
        viewModelScope.launch {
            val books: List<Book> = getBooksUC()
            val position = (0..7).random()
            book.postValue(books[position])
        }
    }
}