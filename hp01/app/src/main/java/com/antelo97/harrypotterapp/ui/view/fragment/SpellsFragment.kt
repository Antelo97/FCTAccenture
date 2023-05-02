package com.antelo97.harrypotterapp.ui.view.fragment

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
import com.antelo97.harrypotterapp.R
import com.antelo97.harrypotterapp.databinding.FragmentSpellsBinding
import com.antelo97.harrypotterapp.ui.view.fragment.adapter.SpellsAdapter
import com.antelo97.harrypotterapp.ui.viewmodel.MainViewModel
import kotlinx.coroutines.launch

class SpellsFragment : Fragment() {
    private lateinit var bindingSpellsFragment: FragmentSpellsBinding
    private lateinit var spellsAdapter: SpellsAdapter

    private val mainViewModel: MainViewModel by activityViewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Observers
        mainViewModel.foundSpells.observe(this) { foundSpells ->
            spellsAdapter.updateList(foundSpells)
        }

        mainViewModel.isLoadingSpells.observe(this) { isLoadingSpells ->
            bindingSpellsFragment.pbSpells.isVisible = isLoadingSpells
        }

        mainViewModel.mbtnAllSpells.observe(this) { mbtnAllSpell ->
            bindingSpellsFragment.mbtnAllSpells.isEnabled = mbtnAllSpell

            // Asigna la lista de colores al backgroundTint del botón
            bindingSpellsFragment.mbtnAllSpells.backgroundTintList = getColorStateListSpells()
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        // Inflate the layout for this fragment
        bindingSpellsFragment = FragmentSpellsBinding.inflate(inflater, container, false)
        initUI()
        return bindingSpellsFragment.root
    }

    private fun initUI() {
        bindingSpellsFragment.svSpells.setOnQueryTextListener(object :
            SearchView.OnQueryTextListener {
            override fun onQueryTextSubmit(query: String?): Boolean {
                mainViewModel.searchSpellsByName(query.orEmpty())
                return false
            }

            override fun onQueryTextChange(newText: String?) = false
        })

        bindingSpellsFragment.mbtnFavSpells.setOnClickListener {
            /*bindingSpellsFragment.rvSpells.scrollToPosition(
                (mainViewModel.foundSpells.value?.size?.minus(1)) ?: 0
            )*/
            mainViewModel.viewModelScope.launch {
                if (!bindingSpellsFragment.mbtnAllSpells.isEnabled) {
                    mainViewModel.updateAllMBtnSpell(false)
                }
                mainViewModel.showFavoriteSpells()
            }
        }

        bindingSpellsFragment.mbtnAllSpells.isEnabled = mainViewModel.mbtnAllSpells.value ?: false
        bindingSpellsFragment.mbtnAllSpells.backgroundTintList = getColorStateListSpells()
        bindingSpellsFragment.mbtnAllSpells.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.updateAllMBtnSpell(it.isEnabled)
                mainViewModel.showAllSpells()
            }
        }

        spellsAdapter = SpellsAdapter(mainViewModel)
        bindingSpellsFragment.rvSpells.setHasFixedSize(true)
        bindingSpellsFragment.rvSpells.layoutManager = LinearLayoutManager(requireContext())
        bindingSpellsFragment.rvSpells.adapter = spellsAdapter
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