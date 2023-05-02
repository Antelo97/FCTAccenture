package com.antelo97.harrypotterapp.ui.view.fragment

//noinspection SuspiciousImport
import android.R
import android.content.res.ColorStateList
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.appcompat.widget.SearchView
import androidx.core.content.ContextCompat
import androidx.fragment.app.activityViewModels
import androidx.lifecycle.viewModelScope
import androidx.recyclerview.widget.LinearLayoutManager
import com.antelo97.harrypotterapp.databinding.FragmentCharactersBinding
import com.antelo97.harrypotterapp.ui.view.fragment.adapter.CharactersAdapter
import com.antelo97.harrypotterapp.ui.viewmodel.MainViewModel
import kotlinx.coroutines.launch

class CharactersFragment : Fragment() {
    private lateinit var charactersBinding: FragmentCharactersBinding
    private lateinit var charactersAdapter: CharactersAdapter

    private val mainViewModel: MainViewModel by activityViewModels()

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        charactersBinding = FragmentCharactersBinding.inflate(inflater, container, false)
        initUI()
        initObservers()
        return charactersBinding.root
    }

    private fun initUI() {
        mainViewModel.updateTvEmpyList(mainViewModel.foundCharacters.value!!.size)

        charactersBinding.svCharacters.setOnQueryTextListener(object :
            SearchView.OnQueryTextListener {
            override fun onQueryTextSubmit(query: String?): Boolean {
                mainViewModel.viewModelScope.launch {
                    mainViewModel.searchCharactersByName(query.orEmpty())
                    mainViewModel.updateButtonStatesCharacters()
                }
                return false
            }

            override fun onQueryTextChange(newText: String?) = false
        })

        charactersBinding.mbtnFavCharacters.backgroundTintList = getColorStateListCharacters()
        charactersBinding.mbtnFavCharacters.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.showFavoriteCharacters()
                mainViewModel.updateButtonStatesCharacters()
            }
        }

        charactersBinding.mbtnAllCharacters.backgroundTintList = getColorStateListCharacters()
        charactersBinding.mbtnAllCharacters.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.showAllCharacters()
                mainViewModel.updateButtonStatesCharacters()
            }
        }

        charactersBinding.mbtnGoTopCharacters.backgroundTintList = getColorStateListCharacters()
        charactersBinding.mbtnGoTopCharacters.setOnClickListener {
            val layoutManager = charactersBinding.rvCharacters.layoutManager
            layoutManager?.scrollToPosition(0)
        }

        charactersBinding.mbtnGoDownCharacters.backgroundTintList = getColorStateListCharacters()
        charactersBinding.mbtnGoDownCharacters.setOnClickListener {
            val layoutManager = charactersBinding.rvCharacters.layoutManager
            layoutManager?.scrollToPosition(mainViewModel.foundCharacters.value!!.size.minus(1))
        }

        charactersBinding.mbtnRandomCharacters.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.showRandomCharacter()
                mainViewModel.updateButtonStatesCharacters()
            }
        }

        charactersBinding.mbtnAZCharacters.backgroundTintList = getColorStateListCharacters()
        charactersBinding.mbtnAZCharacters.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.showCharactersAtoZ()
            }
        }

        charactersBinding.mbtnZACharacters.backgroundTintList = getColorStateListCharacters()
        charactersBinding.mbtnZACharacters.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.showCharactersZtoA()
            }
        }

        charactersAdapter = CharactersAdapter(mainViewModel, viewLifecycleOwner)
        charactersBinding.rvCharacters.setHasFixedSize(true)
        charactersBinding.rvCharacters.layoutManager = LinearLayoutManager(requireContext())
        charactersBinding.rvCharacters.adapter = charactersAdapter
    }

    private fun initObservers() {
        mainViewModel.foundCharacters.observe(viewLifecycleOwner) { foundCharacters ->
            charactersAdapter.updateList(foundCharacters)
            if (foundCharacters.isEmpty()) {
                charactersBinding.mbtnGoTopCharacters.isEnabled = false
                charactersBinding.mbtnGoTopCharacters.backgroundTintList = getColorStateListCharacters()
                charactersBinding.mbtnGoDownCharacters.isEnabled = false
                charactersBinding.mbtnGoDownCharacters.backgroundTintList = getColorStateListCharacters()
                charactersBinding.mbtnAZCharacters.isEnabled = false
                charactersBinding.mbtnAZCharacters.backgroundTintList = getColorStateListCharacters()
                charactersBinding.mbtnZACharacters.isEnabled = false
                charactersBinding.mbtnZACharacters.backgroundTintList = getColorStateListCharacters()
            } else {
                charactersBinding.mbtnGoTopCharacters.isEnabled = true
                charactersBinding.mbtnGoTopCharacters.backgroundTintList = getColorStateListCharacters()
                charactersBinding.mbtnGoDownCharacters.isEnabled = true
                charactersBinding.mbtnGoDownCharacters.backgroundTintList = getColorStateListCharacters()
                charactersBinding.mbtnAZCharacters.isEnabled = true
                charactersBinding.mbtnAZCharacters.backgroundTintList = getColorStateListCharacters()
                charactersBinding.mbtnZACharacters.isEnabled = true
                charactersBinding.mbtnZACharacters.backgroundTintList = getColorStateListCharacters()
            }
        }

        mainViewModel.mbtnAllCharacters.observe(viewLifecycleOwner) { isEnabled ->
            charactersBinding.mbtnAllCharacters.isEnabled = isEnabled
            charactersBinding.mbtnAllCharacters.backgroundTintList = getColorStateListCharacters()
        }

        mainViewModel.mbtnFavCharacters.observe(viewLifecycleOwner) { isEnabled ->
            charactersBinding.mbtnFavCharacters.isEnabled = isEnabled
            charactersBinding.mbtnFavCharacters.backgroundTintList = getColorStateListCharacters()
        }
    }

    private fun getColorStateListCharacters(): ColorStateList {
        return ColorStateList(
            arrayOf(
                intArrayOf(R.attr.state_enabled),
                intArrayOf(-R.attr.state_enabled)
            ),
            intArrayOf(
                ContextCompat.getColor(
                    requireContext(), com.antelo97.harrypotterapp.R.color.hp_gold
                ),
                ContextCompat.getColor(
                    requireContext(), com.antelo97.harrypotterapp.R.color.hp_black_opacity_50
                )
            )
        )
    }

    companion object {
        @JvmStatic
        fun newInstance() = CharactersFragment()
    }

    // Para asegurar de recuperar el estado a través del Bundle (=JSON)

    /* override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
        outState.putString("textViewText", textView.text.toString())
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if (savedInstanceState != null) {
            val textViewText = savedInstanceState.getString("textViewText")
            textView.text = textViewText
        }
    } */
}