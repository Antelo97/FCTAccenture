package com.antelo97.harrypotterapp.ui.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.antelo97.harrypotterapp.domain.model.Book
import com.antelo97.harrypotterapp.domain.model.Spell
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
    private val getFavoriteBooksUC: GetFavoriteBooksUC,
    private val getFavoriteSpells: GetFavoriteSpellsUC
) : ViewModel() {

    // MainActivity
    val isLoadingMain: MutableLiveData<Boolean> = MutableLiveData<Boolean>()

    // BooksFragment
    val foundBooks: MutableLiveData<List<Book>> = MutableLiveData<List<Book>>()
    val isLoadingBooks: MutableLiveData<Boolean> = MutableLiveData<Boolean>()
    val favoriteList: MutableList<MutableLiveData<Int>> = mutableListOf()
    val mbtnAllBooks: MutableLiveData<Boolean> = MutableLiveData<Boolean>()

    // CharactersFragment

    // SpellsFragment
    val foundSpells: MutableLiveData<List<Spell>> = MutableLiveData<List<Spell>>()
    val isLoadingSpells: MutableLiveData<Boolean> = MutableLiveData<Boolean>()
    val mbtnAllSpells: MutableLiveData<Boolean> = MutableLiveData<Boolean>()

    // SpeciesFragment

    fun onCreate() {
        /*isLoadingBooks.postValue(true)
        viewModelScope.launch {
            loadAllData()
            foundBooks.value?.let { books ->
                for (i in books.indices) {
                    favoriteList.add(MutableLiveData())
                    favoriteList[i].postValue(0)
                }
            }
        }
        isLoadingBooks.postValue(false)*/
    }

    private suspend fun loadBooks() {
        foundBooks.postValue(getBooksUC())
    }

    private suspend fun loadCharacters() {
        getCharactersUC()
    }

    private suspend fun loadSpells() {
        foundSpells.postValue(getSpellsUC())
    }

    private suspend fun loadSpecies() {
        getSpeciesUC()
    }

    suspend fun loadAllData() {
        isLoadingMain.postValue(true)
        loadBooks()
        loadCharacters()
        loadSpells()
        loadSpecies()
        isLoadingMain.postValue(false)
    }

    fun searchBooksByTitle(bookTitle: String) {
        isLoadingMain.postValue(true)
        viewModelScope.launch {
            foundBooks.postValue(getBooksByTitleUC(bookTitle))
        }
        isLoadingMain.postValue(false)
    }

    fun searchSpellsByName(spellName: String) {
        isLoadingSpells.postValue(true)
        viewModelScope.launch {
            foundSpells.postValue(getSpellsByNameUC(spellName))
        }
        isLoadingSpells.postValue(true)
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

    suspend fun showFavoriteSpells() {
        foundSpells.postValue(getFavoriteSpells())
    }

    suspend fun showAllBooks() {
        foundBooks.postValue(getBooksUC())
    }

    suspend fun showAllSpells() {
        foundSpells.postValue(getSpellsUC())
    }

    fun updateAllMBtnBook(state: Boolean) {
        mbtnAllBooks.postValue(!state)
    }

    fun updateAllMBtnSpell(state: Boolean) {
        mbtnAllSpells.postValue(!state)
    }
}