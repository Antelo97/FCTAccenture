package com.antelo97.harrypotterapp.ui.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.antelo97.harrypotterapp.domain.model.Book
import com.antelo97.harrypotterapp.domain.model.Species
import com.antelo97.harrypotterapp.domain.model.Spell
import com.antelo97.harrypotterapp.domain.usecase.book.*
import com.antelo97.harrypotterapp.domain.usecase.character.*
import com.antelo97.harrypotterapp.domain.usecase.species.*
import com.antelo97.harrypotterapp.domain.usecase.spell.*
import dagger.hilt.android.lifecycle.HiltViewModel
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
    private val getFavoriteSpeciesUC: GetFavoriteSpeciesUC,
    private val getRandomBookUC: GetRandomBookUC,
    private val getRandomCharacterUC: GetRandomCharacterUC,
    private val getRandomSpellUC: GetRandomSpellUC,
    private val getRandomSpeciesUC: GetRandomSpeciesUC,
    private val getBooksAlphAscUC: GetBooksAlphAscUC,
    private val getCharactersAlphAscUC: GetCharactersAlphAscUC,
    private val getSpellsAlphAscUC: GetSpellsAlphAscUC,
    private val getSpeciesAlphAscUC: GetSpeciesAlphAscUC,
    private val getBooksAlphDescUC: GetBooksAlphDescUC,
    private val getCharactersAlphDescUC: GetCharactersAlphDescUC,
    private val getSpellsAlphDescUC: GetSpellsAlphDescUC,
    private val getSpeciesAlphDescUC: GetSpeciesAlphDescUC,
    private val deleteFavBooksUC: DeleteFavBooksUC,
    private val deleteFavCharactersUC: DeleteFavCharactersUC,
    private val deleteFavSpellsUC: DeleteFavSpellsUC,
    private val deleteFavSpeciesUC: DeleteFavSpeciesUC
) : ViewModel() {

    // MainActivity
    val tvEmail: MutableLiveData<String> = MutableLiveData<String>()
    val pbForActivity: MutableLiveData<Boolean> = MutableLiveData<Boolean>()
    val pbForFragments: MutableLiveData<Boolean> = MutableLiveData<Boolean>()
    val ivMain: MutableLiveData<Boolean> = MutableLiveData<Boolean>()
    val tvEmptyList: MutableLiveData<Boolean> = MutableLiveData<Boolean>()

    // BooksFragment
    val foundBooks: MutableLiveData<List<Book>> = MutableLiveData<List<Book>>()
    val mbtnAllBooks: MutableLiveData<Boolean> = MutableLiveData<Boolean>()
    val mbtnFavBooks: MutableLiveData<Boolean> = MutableLiveData<Boolean>()

    // CharactersFragment
    val foundCharacters: MutableLiveData<List<com.antelo97.harrypotterapp.domain.model.Character>> =
        MutableLiveData<List<com.antelo97.harrypotterapp.domain.model.Character>>()
    val mbtnAllCharacters: MutableLiveData<Boolean> = MutableLiveData<Boolean>()
    val mbtnFavCharacters: MutableLiveData<Boolean> = MutableLiveData<Boolean>()

    // SpellsFragment
    val foundSpells: MutableLiveData<List<Spell>> = MutableLiveData<List<Spell>>()
    val mbtnAllSpells: MutableLiveData<Boolean> = MutableLiveData<Boolean>()
    val mbtnFavSpells: MutableLiveData<Boolean> = MutableLiveData<Boolean>()

    // SpeciesFragment
    val foundSpecies: MutableLiveData<List<Species>> = MutableLiveData<List<Species>>()
    val mbtnAllSpecies: MutableLiveData<Boolean> = MutableLiveData<Boolean>()
    val mbtnFavSpecies: MutableLiveData<Boolean> = MutableLiveData<Boolean>()

    fun setEmail(email: String) {
        tvEmail.postValue(email)
    }

    fun disabledIvMain() {
        ivMain.postValue(false)
    }

    fun disabledTvEmpyList() {
        tvEmptyList.postValue(false)
    }

    fun updateTvEmpyList(size: Int) {
        tvEmptyList.postValue(size == 0)
    }

    private suspend fun loadBooks() {
        foundBooks.postValue(getBooksUC())
    }

    private suspend fun loadCharacters() {
        foundCharacters.postValue(getCharactersUC())
    }

    private suspend fun loadSpells() {
        foundSpells.postValue(getSpellsUC())
    }

    private suspend fun loadSpecies() {
        foundSpecies.postValue(getSpeciesUC())
    }

    suspend fun loadAllData() {
        loadBooks()
        loadCharacters()
        loadSpells()
        loadSpecies()
        pbForActivity.postValue(false)
    }

    suspend fun searchBooksByTitle(bookTitle: String) {
        pbForFragments.postValue(true)
        foundBooks.postValue(getBooksByTitleUC(bookTitle))
        pbForFragments.postValue(false)
    }

    suspend fun searchCharactersByName(characterName: String) {
        pbForFragments.postValue(true)
        foundCharacters.postValue(getCharactersByNameUC(characterName))
        pbForFragments.postValue(false)
    }

    suspend fun searchSpellsByName(spellName: String) {
        pbForFragments.postValue(true)
        foundSpells.postValue(getSpellsByNameUC(spellName))
        pbForFragments.postValue(false)

    }

    suspend fun searchSpeciesByName(speciesName: String) {
        pbForFragments.postValue(true)
        foundSpecies.postValue(getSpeciesByNameUC(speciesName))
        pbForFragments.postValue(false)

    }

    suspend fun updateFavoriteBook(book: Book, position: Int) {
        foundBooks.postValue(foundBooks.value?.apply {
            get(position).isFavorite = !book.isFavorite
        })
        updateBookUC(book)
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
        foundSpells.postValue(foundSpells.value?.apply {
            get(position).isFavorite = !spell.isFavorite
        })
        updateSpellUC(spell)
    }

    suspend fun updateFavoriteSpecies(species: Species, position: Int) {
        foundSpecies.postValue(foundSpecies.value?.apply {
            get(position).isFavorite = !species.isFavorite
        })
        updateSpeciesUC(species)
    }

    suspend fun showAllBooks() {
        pbForFragments.postValue(true)
        foundBooks.postValue(getBooksUC())
        pbForFragments.postValue(false)
    }

    suspend fun showAllCharacters() {
        pbForFragments.postValue(true)
        foundCharacters.postValue(getCharactersUC())
        pbForFragments.postValue(false)
    }

    suspend fun showAllSpells() {
        pbForFragments.postValue(true)
        foundSpells.postValue(getSpellsUC())
        pbForFragments.postValue(false)
    }

    suspend fun showAllSpecies() {
        pbForFragments.postValue(true)
        foundSpecies.postValue(getSpeciesUC())
        pbForFragments.postValue(false)
    }

    suspend fun showFavoriteBooks() {
        pbForFragments.postValue(true)
        foundBooks.postValue(getFavoriteBooksUC())
        pbForFragments.postValue(false)
    }

    suspend fun showFavoriteCharacters() {
        pbForFragments.postValue(true)
        foundCharacters.postValue(getFavoriteCharactersUC())
        pbForFragments.postValue(false)
    }

    suspend fun showFavoriteSpells() {
        pbForFragments.postValue(true)
        foundSpells.postValue(getFavoriteSpellsUC())
        pbForFragments.postValue(false)
    }

    suspend fun showFavoriteSpecies() {
        pbForFragments.postValue(true)
        foundSpecies.postValue(getFavoriteSpeciesUC())
        pbForFragments.postValue(false)
    }

    suspend fun showRandomBook() {
        pbForFragments.postValue(true)
        foundBooks.postValue(getRandomBookUC())
        pbForFragments.postValue(false)
    }

    suspend fun showRandomCharacter() {
        pbForFragments.postValue(true)
        foundCharacters.postValue(getRandomCharacterUC())
        pbForFragments.postValue(false)
    }

    suspend fun showRandomSpell() {
        pbForFragments.postValue(true)
        foundSpells.postValue(getRandomSpellUC())
        pbForFragments.postValue(false)
    }

    suspend fun showRandomSpecies() {
        pbForFragments.postValue(true)
        foundSpecies.postValue(getRandomSpeciesUC())
        pbForFragments.postValue(false)
    }

    fun showBooksAtoZ() {
        pbForFragments.postValue(true)
        foundBooks.postValue(getBooksAlphAscUC(foundBooks.value!!))
        pbForFragments.postValue(false)
    }

    fun showCharactersAtoZ() {
        pbForFragments.postValue(true)
        foundCharacters.postValue(getCharactersAlphAscUC(foundCharacters.value!!))
        pbForFragments.postValue(false)
    }

    fun showSpellsAtoZ() {
        pbForFragments.postValue(true)
        foundSpells.postValue(getSpellsAlphAscUC(foundSpells.value!!))
        pbForFragments.postValue(false)
    }

    fun showSpeciesAtoZ() {
        pbForFragments.postValue(true)
        foundSpecies.postValue(getSpeciesAlphAscUC(foundSpecies.value!!))
        pbForFragments.postValue(false)
    }

    fun showBooksZtoA() {
        pbForFragments.postValue(true)
        foundBooks.postValue(getBooksAlphDescUC(foundBooks.value!!))
        pbForFragments.postValue(false)
    }

    fun showCharactersZtoA() {
        pbForFragments.postValue(true)
        foundCharacters.postValue(getCharactersAlphDescUC(foundCharacters.value!!))
        pbForFragments.postValue(false)
    }

    fun showSpellsZtoA() {
        pbForFragments.postValue(true)
        foundSpells.postValue(getSpellsAlphDescUC(foundSpells.value!!))
        pbForFragments.postValue(false)
    }

    fun showSpeciesZtoA() {
        pbForFragments.postValue(true)
        foundSpecies.postValue(getSpeciesAlphDescUC(foundSpecies.value!!))
        pbForFragments.postValue(false)
    }

    suspend fun deleteFavBooks() {
        pbForFragments.postValue(true)
        deleteFavBooksUC()
        foundBooks.postValue(getBooksUC())
        pbForFragments.postValue(false)
    }

    suspend fun deleteFavCharacters() {
        pbForFragments.postValue(true)
        deleteFavCharactersUC()
        foundCharacters.postValue(getCharactersUC())
        pbForFragments.postValue(false)
    }

    suspend fun deleteFavSpells() {
        pbForFragments.postValue(true)
        deleteFavSpellsUC()
        foundSpells.postValue(getSpellsUC())
        pbForFragments.postValue(false)
    }

    suspend fun deleteFavSpecies() {
        pbForFragments.postValue(true)
        deleteFavSpeciesUC()
        foundSpecies.postValue(getSpeciesUC())
        pbForFragments.postValue(false)
    }

    suspend fun updateButtonStatesBook() {
        if (getBooksUC().size == foundBooks.value!!.size) {
            mbtnAllBooks.postValue(false)
        } else {
            mbtnAllBooks.postValue(true)
        }

        if (getFavoriteBooksUC().size == foundBooks.value!!.filter { it.isFavorite }.size
            && getFavoriteBooksUC().size == foundBooks.value!!.size
        ) {
            mbtnFavBooks.postValue(false)
        } else {
            mbtnFavBooks.postValue(true)
        }
    }

    suspend fun updateButtonStatesCharacters() {
        if (getCharactersUC().size == foundCharacters.value!!.size) {
            mbtnAllCharacters.postValue(false)
        } else {
            mbtnAllCharacters.postValue(true)
        }

        if (getFavoriteCharactersUC().size == foundCharacters.value!!.filter { it.isFavorite }.size
            && getFavoriteCharactersUC().size == foundCharacters.value!!.size
        ) {
            mbtnFavCharacters.postValue(false)
        } else {
            mbtnFavCharacters.postValue(true)
        }
    }

    suspend fun updateButtonStatesSpells() {
        if (getSpellsUC().size == foundSpells.value!!.size) {
            mbtnAllSpells.postValue(false)
        } else {
            mbtnAllSpells.postValue(true)
        }

        if (getFavoriteSpellsUC().size == foundSpells.value!!.filter { it.isFavorite }.size
            && getFavoriteSpellsUC().size == foundSpells.value!!.size
        ) {
            mbtnFavSpells.postValue(false)
        } else {
            mbtnFavSpells.postValue(true)
        }
    }

    suspend fun updateButtonStatesSpecies() {
        if (getSpeciesUC().size == foundSpecies.value!!.size) {
            mbtnAllSpecies.postValue(false)
        } else {
            mbtnAllSpecies.postValue(true)
        }

        if (getFavoriteSpeciesUC().size == foundSpecies.value!!.filter { it.isFavorite }.size
            && getFavoriteSpeciesUC().size == foundSpecies.value!!.size
        ) {
            mbtnFavSpecies.postValue(false)
        } else {
            mbtnFavSpecies.postValue(true)
        }
    }
}