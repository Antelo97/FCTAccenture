package com.antelo97.harrypotterapp.ui.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.antelo97.harrypotterapp.R
import com.antelo97.harrypotterapp.domain.model.Book
import com.antelo97.harrypotterapp.domain.usecase.*
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class MainViewModel @Inject constructor(
    private val getBooksUC: GetBooksUC,
    private val getCharactersUC: GetCharactersUC,
    private val getSpellsUC: GetSpellsUC,
    private val getSpeciesUC: GetSpeciesUC,
    private val getBooksByTitleUC: GetBooksByTitleUC,
    private val getCharactersByNameUC: GetCharactersByNameUC,
    private val getSpellsByNameUC: GetSpellsByNameUC,
    private val getSpeciesByNameUC: GetSpeciesByNameUC,
    private val updateBookUC: UpdateBookUC,
    private val getFavoriteBooksUC: GetFavoriteBooksUC
) : ViewModel() {

    val isLoadingBooks: MutableLiveData<Boolean> = MutableLiveData<Boolean>()
    val foundBooks: MutableLiveData<List<Book>> = MutableLiveData<List<Book>>()
    val favoriteList: MutableList<MutableLiveData<Int>> = mutableListOf()

    fun onCreate() {
        viewModelScope.launch {
            loadAllData()

            foundBooks.value?.let { books ->
                for (i in books.indices) {
                    favoriteList.add(MutableLiveData())
                    favoriteList[i].postValue(0)
                }
            }
        }
    }

    private suspend fun loadBooks() {
        foundBooks.postValue(getBooksUC())
    }

    private suspend fun loadCharacters() {
        getCharactersUC()
    }

    private suspend fun loadSpells() {
        getSpellsUC()
    }

    private suspend fun loadSpecies() {
        getSpeciesUC()
    }

    private suspend fun loadAllData() {
        loadBooks()
        loadCharacters()
        loadSpells()
        loadSpecies()
    }

    fun searchBooksByTitle(bookTitle: String) {
        isLoadingBooks.postValue(true)
        viewModelScope.launch {
            foundBooks.postValue(getBooksByTitleUC(bookTitle))
            isLoadingBooks.postValue(false)
        }
    }

    suspend fun updateFavoriteBook(book: Book, position: Int) {

        if (!book.isFavorite) {
            foundBooks.postValue(foundBooks.value?.apply {
                get(position).isFavorite = true
            })
            updateBookUC(book)
            //favoriteList[position].postValue(R.color.hp_negro)
        } else {
            foundBooks.postValue(foundBooks.value?.apply {
                get(position).isFavorite = false
            })
            updateBookUC(book)
            //favoriteList[position].postValue(R.color.hp_oro)
        }
    }

    suspend fun showFavoriteBooks() {
        foundBooks.postValue(getFavoriteBooksUC())
    }
}