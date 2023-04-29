package com.antelo97.harrypotterapp.ui.view.fragment

import android.R
import android.content.res.ColorStateList
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.appcompat.widget.SearchView
import androidx.core.content.ContextCompat
import androidx.core.view.isVisible
import androidx.fragment.app.activityViewModels
import androidx.lifecycle.viewModelScope
import androidx.recyclerview.widget.LinearLayoutManager
import com.antelo97.harrypotterapp.databinding.FragmentCharactersBinding
import com.antelo97.harrypotterapp.ui.view.fragment.adapter.CharactersAdapter
import com.antelo97.harrypotterapp.ui.viewmodel.MainViewModel
import kotlinx.coroutines.launch

class CharactersFragment : Fragment() {
    // Declaración del Binding
    private lateinit var bindingCharactersFragment: FragmentCharactersBinding

    // Declaración del Adapter
    private lateinit var charactersAdapter: CharactersAdapter

    private val mainViewModel: MainViewModel by activityViewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        initObservers()
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        // Inicialización del Binding
        bindingCharactersFragment = FragmentCharactersBinding.inflate(inflater, container, false)
        initUI()
        return bindingCharactersFragment.root
    }

    private fun initUI() {
        bindingCharactersFragment.svCharacters.setOnQueryTextListener(object :
            SearchView.OnQueryTextListener {
            override fun onQueryTextSubmit(query: String?): Boolean {
                mainViewModel.searchSpeciesByName(query.orEmpty())
                return false
            }

            override fun onQueryTextChange(newText: String?) = false
        })

        bindingCharactersFragment.mbtnFavCharacters.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.showFavoriteCharacters()
            }
        }

        bindingCharactersFragment.mbtnAllCharacters.backgroundTintList =
            getColorStateListCharacters()
        bindingCharactersFragment.mbtnAllCharacters.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.showAllCharacters()
            }
        }

        // Inicialización del Adapter
        charactersAdapter = CharactersAdapter(mainViewModel, viewLifecycleOwner)
        bindingCharactersFragment.rvCharacters.setHasFixedSize(true)
        bindingCharactersFragment.rvCharacters.layoutManager = LinearLayoutManager(requireContext())
        bindingCharactersFragment.rvCharacters.adapter = charactersAdapter

        bindingCharactersFragment.rvCharacters.setVerticalScrollBarEnabled(true);
    }

    private fun initObservers() {
        mainViewModel.foundCharacters.observe(this) { foundCharacters ->
            charactersAdapter.updateList(foundCharacters)
            if (mainViewModel.foundCharacters.value!!.size != mainViewModel.totalCharacters.value) {
                bindingCharactersFragment.mbtnAllCharacters.isEnabled = true
                bindingCharactersFragment.mbtnAllCharacters.backgroundTintList =
                    getColorStateListCharacters()
            } else {
                bindingCharactersFragment.mbtnAllCharacters.isEnabled = false
                bindingCharactersFragment.mbtnAllCharacters.backgroundTintList =
                    getColorStateListCharacters()
            }
        }

        mainViewModel.totalFavoriteCharacters.observe(this) {
            bindingCharactersFragment.mbtnFavCharacters.isEnabled = true
        }

        mainViewModel.isLoadingCharacters.observe(this) { isLoadingCharacters ->
            bindingCharactersFragment.pbCharacters.isVisible = isLoadingCharacters
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
                    requireContext(),
                    com.antelo97.harrypotterapp.R.color.hp_gold
                ),
                ContextCompat.getColor(
                    requireContext(),
                    com.antelo97.harrypotterapp.R.color.hp_black_opacity_50
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