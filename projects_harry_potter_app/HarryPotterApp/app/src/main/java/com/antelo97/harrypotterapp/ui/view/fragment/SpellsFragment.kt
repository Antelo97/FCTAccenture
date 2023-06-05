package com.antelo97.harrypotterapp.ui.view.fragment

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
import com.antelo97.harrypotterapp.R
import com.antelo97.harrypotterapp.databinding.FragmentSpellsBinding
import com.antelo97.harrypotterapp.ui.view.fragment.adapter.SpellsAdapter
import com.antelo97.harrypotterapp.ui.viewmodel.MainViewModel
import kotlinx.coroutines.launch

class SpellsFragment : Fragment() {
    private lateinit var spellsBinding: FragmentSpellsBinding
    private lateinit var spellsAdapter: SpellsAdapter

    private val mainViewModel: MainViewModel by activityViewModels()

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        spellsBinding = FragmentSpellsBinding.inflate(inflater, container, false)
        initUI()
        initObservers()
        return spellsBinding.root
    }

    private fun initUI() {
        mainViewModel.updateTvEmpyList(mainViewModel.foundSpells.value!!.size)

        spellsBinding.svSpells.setOnQueryTextListener(object :
            SearchView.OnQueryTextListener {
            override fun onQueryTextSubmit(query: String?): Boolean {
                mainViewModel.viewModelScope.launch {
                    mainViewModel.searchSpellsByName(query.orEmpty())
                    mainViewModel.updateButtonStatesSpells()
                }
                return false
            }

            override fun onQueryTextChange(newText: String?) = false
        })

        spellsBinding.mbtnFavSpells.backgroundTintList = getColorStateListSpells()
        spellsBinding.mbtnFavSpells.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.showFavoriteSpells()
                mainViewModel.updateButtonStatesSpells()
            }
        }

        spellsBinding.mbtnAllSpells.backgroundTintList = getColorStateListSpells()
        spellsBinding.mbtnAllSpells.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.showAllSpells()
                mainViewModel.updateButtonStatesSpells()
            }
        }

        spellsBinding.mbtnGoTopSpells.backgroundTintList = getColorStateListSpells()
        spellsBinding.mbtnGoTopSpells.setOnClickListener {
            spellsBinding.rvSpells.scrollToPosition(0)
        }

        spellsBinding.mbtnGoDownSpells.backgroundTintList = getColorStateListSpells()
        spellsBinding.mbtnGoDownSpells.setOnClickListener {
            val layoutManager = spellsBinding.rvSpells.layoutManager
            layoutManager?.scrollToPosition(mainViewModel.foundSpells.value!!.size.minus(1))
        }

        spellsBinding.mbtnRandomSpells.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.showRandomSpell()
                mainViewModel.updateButtonStatesSpells()
            }
        }

        spellsBinding.mbtnAZSpells.backgroundTintList = getColorStateListSpells()
        spellsBinding.mbtnAZSpells.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.showSpellsAtoZ()
            }
        }

        spellsBinding.mbtnZASpells.backgroundTintList = getColorStateListSpells()
        spellsBinding.mbtnZASpells.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.showSpellsZtoA()
            }
        }

        spellsAdapter = SpellsAdapter(mainViewModel, viewLifecycleOwner)
        spellsBinding.rvSpells.setHasFixedSize(true)
        spellsBinding.rvSpells.layoutManager = LinearLayoutManager(requireContext())
        spellsBinding.rvSpells.adapter = spellsAdapter
    }

    private fun initObservers() {
        mainViewModel.foundSpells.observe(viewLifecycleOwner) { foundSpells ->
            spellsAdapter.updateList(foundSpells)
            if (foundSpells.isEmpty()) {
                spellsBinding.mbtnGoTopSpells.isEnabled = false
                spellsBinding.mbtnGoTopSpells.backgroundTintList = getColorStateListSpells()
                spellsBinding.mbtnGoDownSpells.isEnabled = false
                spellsBinding.mbtnGoDownSpells.backgroundTintList = getColorStateListSpells()
                spellsBinding.mbtnAZSpells.isEnabled = false
                spellsBinding.mbtnAZSpells.backgroundTintList = getColorStateListSpells()
                spellsBinding.mbtnZASpells.isEnabled = false
                spellsBinding.mbtnZASpells.backgroundTintList = getColorStateListSpells()
            } else {
                spellsBinding.mbtnGoTopSpells.isEnabled = true
                spellsBinding.mbtnGoTopSpells.backgroundTintList = getColorStateListSpells()
                spellsBinding.mbtnGoDownSpells.isEnabled = true
                spellsBinding.mbtnGoDownSpells.backgroundTintList = getColorStateListSpells()
                spellsBinding.mbtnAZSpells.isEnabled = true
                spellsBinding.mbtnAZSpells.backgroundTintList = getColorStateListSpells()
                spellsBinding.mbtnZASpells.isEnabled = true
                spellsBinding.mbtnZASpells.backgroundTintList = getColorStateListSpells()
            }
        }

        mainViewModel.mbtnAllSpells.observe(viewLifecycleOwner) { isEnabled ->
            spellsBinding.mbtnAllSpells.isEnabled = isEnabled
            spellsBinding.mbtnAllSpells.backgroundTintList = getColorStateListSpells()
        }

        mainViewModel.mbtnFavSpells.observe(viewLifecycleOwner) { isEnabled ->
            spellsBinding.mbtnFavSpells.isEnabled = isEnabled
            spellsBinding.mbtnFavSpells.backgroundTintList = getColorStateListSpells()
        }
    }

    private fun getColorStateListSpells(): ColorStateList {
        return ColorStateList(
            arrayOf(
                intArrayOf(android.R.attr.state_enabled),
                intArrayOf(-android.R.attr.state_enabled)
            ),
            intArrayOf(
                ContextCompat.getColor(requireContext(), R.color.hp_gold),
                ContextCompat.getColor(requireContext(), R.color.hp_black_opacity_50)
            )
        )
    }

    companion object {
        @JvmStatic
        fun newInstance() = SpellsFragment()
    }
}