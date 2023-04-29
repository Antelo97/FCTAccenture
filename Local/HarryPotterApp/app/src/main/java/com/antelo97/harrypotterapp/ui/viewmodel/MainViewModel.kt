package com.antelo97.harrypotterapp.ui.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.antelo97.harrypotterapp.domain.model.Book
import com.antelo97.harrypotterapp.domain.model.Species
import com.antelo97.harrypotterapp.domain.model.Spell
import com.antelo97.harrypotterapp.domain.usecase.book.GetBooksByTitleUC
import com.antelo97.harrypotterapp.domain.usecase.book.GetBooksUC
import com.antelo97.harrypotterapp.domain.usecase.book.GetFavoriteBooksUC
import com.antelo97.harrypotterapp.domain.usecase.book.UpdateBookUC
import com.antelo97.harrypotterapp.domain.usecase.character.GetCharactersByNameUC
import com.antelo97.harrypotterapp.domain.usecase.character.GetCharactersUC
import com.antelo97.harrypotterapp.domain.usecase.character.GetFavoriteCharactersUC
import com.antelo97.harrypotterapp.domain.usecase.character.UpdateCharactersUC
import com.antelo97.harrypotterapp.domain.usecase.species.GetFavoriteSpeciesUC
import com.antelo97.harrypotterapp.domain.usecase.species.GetSpeciesByNameUC
import com.antelo97.harrypotterapp.domain.usecase.species.GetSpeciesUC
import com.antelo97.harrypotterapp.domain.usecase.species.UpdateSpeciesUC
import com.antelo97.harrypotterapp.domain.usecase.spell.GetFavoriteSpellsUC
import com.antelo97.harrypotterapp.domain.usecase.spell.GetSpellsByNameUC
import com.antelo97.harrypotterapp.domain.usecase.spell.GetSpellsUC
import com.antelo97.harrypotterapp.domain.usecase.spell.UpdateSpellUC
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
    private val updateCharacterUC: UpdateCharactersUC,
    private val updateSpellUC: UpdateSpellUC,
    private val updateSpeciesUC: UpdateSpeciesUC,
    private val getFavoriteBooksUC: GetFavoriteBooksUC,
    private val getFavoriteCharactersUC: GetFavoriteCharactersUC,
    private val getFavoriteSpellsUC: GetFavoriteSpellsUC,
    private val getFavoriteSpeciesUC: GetFavoriteSpeciesUC
) : ViewModel() {

    // MainActivity
    val pbMain: MutableLiveData<Boolean> = MutableLiveData<Boolean>()
    val ivMain: MutableLiveData<Boolean> = MutableLiveData<Boolean>()

    // BooksFragment
    val foundBooks: MutableLiveData<List<Book>> = MutableLiveData<List<Book>>()
    val isLoadingBooks: MutableLiveData<Boolean> = MutableLiveData<Boolean>()
    val mbtnAllBooks: MutableLiveData<Boolean> = MutableLiveData<Boolean>()

    // CharactersFragment
    val totalCharacters: MutableLiveData<Int> = MutableLiveData<Int>()
    val totalFavoriteCharacters: MutableLiveData<Int> = MutableLiveData<Int>()
    val foundCharacters: MutableLiveData<List<com.antelo97.harrypotterapp.domain.model.Character>> =
        MutableLiveData<List<com.antelo97.harrypotterapp.domain.model.Character>>()
    val isLoadingCharacters: MutableLiveData<Boolean> = MutableLiveData<Boolean>()
    val detailsCharacter = MutableLiveData(false)

    // SpellsFragment
    val foundSpells: MutableLiveData<List<Spell>> = MutableLiveData<List<Spell>>()
    val isLoadingSpells: MutableLiveData<Boolean> = MutableLiveData<Boolean>()
    val mbtnAllSpells: MutableLiveData<Boolean> = MutableLiveData<Boolean>()

    // SpeciesFragment
    val foundSpecies: MutableLiveData<List<Species>> = MutableLiveData<List<Species>>()
    val isLoadingSpecies: MutableLiveData<Boolean> = MutableLiveData<Boolean>()
    val mbtnAllSpecies: MutableLiveData<Boolean> = MutableLiveData<Boolean>()

    fun disabledIvMain() {
        ivMain.postValue(false)
    }

    private suspend fun loadBooks() {
        foundBooks.postValue(getBooksUC())
    }

    private suspend fun loadCharacters() {
        foundCharacters.postValue(getCharactersUC())
        totalCharacters.postValue(getCharactersUC().size)
        totalFavoriteCharacters.postValue(getFavoriteCharactersUC().size)
    }

    private suspend fun loadSpells() {
        foundSpells.postValue(getSpellsUC())
    }

    private suspend fun loadSpecies() {
        foundSpecies.postValue(getSpeciesUC())
    }

    suspend fun loadAllData() {
        pbMain.postValue(true)
        loadBooks()
        loadCharacters()
        loadSpells()
        loadSpecies()
        pbMain.postValue(false)
    }

    fun searchBooksByTitle(bookTitle: String) {
        pbMain.postValue(true)
        viewModelScope.launch {
            foundBooks.postValue(getBooksByTitleUC(bookTitle))
            pbMain.postValue(false)
        }
    }

    fun searchSpellsByName(spellName: String) {
        isLoadingSpells.postValue(true)
        viewModelScope.launch {
            foundSpells.postValue(getSpellsByNameUC(spellName))
            isLoadingSpells.postValue(false)
        }
    }

    fun searchSpeciesByName(speciesName: String) {
        isLoadingSpecies.postValue(true)
        viewModelScope.launch {
            foundSpecies.postValue(getSpeciesByNameUC(speciesName))
            isLoadingSpecies.postValue(false)
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

    suspend fun updateFavoriteCharacter(
        character: com.antelo97.harrypotterapp.domain.model.Character,
        position: Int
    ) {
        foundCharacters.postValue(foundCharacters.value?.apply {
            get(position).isFavorite = !character.isFavorite
        })
        updateCharacterUC(character)
    }

    suspend fun updateFavoriteSpell(spell: Spell, position: Int) {

        if (!spell.isFavorite) {
            foundSpells.postValue(foundSpells.value?.apply {
                get(position).isFavorite = true
            })
            updateSpellUC(spell)
            //favoriteList[position].postValue(R.color.hp_negro)
        } else {
            foundSpells.postValue(foundSpells.value?.apply {
                get(position).isFavorite = false
            })
            updateSpellUC(spell)
        }
    }

    suspend fun updateFavoriteSpecies(species: Species, position: Int) {

        if (!species.isFavorite) {
            foundSpells.postValue(foundSpells.value?.apply {
                get(position).isFavorite = true
            })
            updateSpeciesUC(species)
        } else {
            foundSpells.postValue(foundSpells.value?.apply {
                get(position).isFavorite = false
            })
            updateSpeciesUC(species)
        }
    }

    suspend fun showFavoriteBooks() {
        foundBooks.postValue(getFavoriteBooksUC())
    }

    suspend fun showFavoriteCharacters() {
        foundCharacters.postValue(getFavoriteCharactersUC())
        totalFavoriteCharacters.postValue(foundCharacters.value!!.filter { it.isFavorite }.size)
    }

    suspend fun showFavoriteSpells() {
        foundSpells.postValue(getFavoriteSpellsUC())
    }

    suspend fun showFavoriteSpecies() {
        foundSpecies.postValue(getFavoriteSpeciesUC())
    }

    suspend fun showAllBooks() {
        foundBooks.postValue(getBooksUC())
    }

    suspend fun showAllCharacters() {
        foundCharacters.postValue(getCharactersUC())
    }

    suspend fun showAllSpells() {
        foundSpells.postValue(getSpellsUC())
    }

    suspend fun showAllSpecies() {
        foundSpecies.postValue(getSpeciesUC())
    }

    fun updateAllMBtnBook(state: Boolean) {
        mbtnAllBooks.postValue(!state)
    }

    fun updateAllMBtnSpell(state: Boolean) {
        mbtnAllSpells.postValue(!state)
    }

    fun updateAllMBtnSpecies(state: Boolean) {
        mbtnAllSpecies.postValue(!state)
    }

    fun updateAllMBtnCharacters(state: Boolean) {
        mbtnAllSpecies.postValue(!state)
    }

    fun modifyInfoDetailCharacter() {
        detailsCharacter.postValue(!detailsCharacter.value!!)
    }
}