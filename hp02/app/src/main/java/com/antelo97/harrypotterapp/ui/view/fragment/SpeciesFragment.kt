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
import com.antelo97.harrypotterapp.databinding.FragmentSpeciesBinding
import com.antelo97.harrypotterapp.ui.view.fragment.adapter.SpeciesAdapter
import com.antelo97.harrypotterapp.ui.viewmodel.MainViewModel
import kotlinx.coroutines.launch

class SpeciesFragment : Fragment() {
    private lateinit var speciesBinding: FragmentSpeciesBinding
    private lateinit var speciesAdapter: SpeciesAdapter

    private val mainViewModel: MainViewModel by activityViewModels()

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        speciesBinding = FragmentSpeciesBinding.inflate(inflater, container, false)
        initUI()
        initObservers()
        return speciesBinding.root
    }

    private fun initUI() {
        mainViewModel.updateTvEmpyList(mainViewModel.foundSpecies.value!!.size)

        speciesBinding.svSpecies.setOnQueryTextListener(object :
            SearchView.OnQueryTextListener {
            override fun onQueryTextSubmit(query: String?): Boolean {
                mainViewModel.viewModelScope.launch {
                    mainViewModel.searchSpeciesByName(query.orEmpty())
                    mainViewModel.updateButtonStatesSpecies()
                }
                return false
            }

            override fun onQueryTextChange(newText: String?) = false
        })

        speciesBinding.mbtnFavSpecies.backgroundTintList = getColorStateListSpecies()
        speciesBinding.mbtnFavSpecies.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.showFavoriteSpecies()
                mainViewModel.updateButtonStatesSpecies()
            }
        }

        speciesBinding.mbtnAllSpecies.backgroundTintList = getColorStateListSpecies()
        speciesBinding.mbtnAllSpecies.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.showAllSpecies()
                mainViewModel.updateButtonStatesSpecies()
            }
        }

        speciesBinding.mbtnGoTopSpecies.backgroundTintList = getColorStateListSpecies()
        speciesBinding.mbtnGoTopSpecies.setOnClickListener {
            val layoutManager = speciesBinding.rvSpecies.layoutManager
            layoutManager?.scrollToPosition(0)
        }

        speciesBinding.mbtnGoDownSpecies.backgroundTintList = getColorStateListSpecies()
        speciesBinding.mbtnGoDownSpecies.setOnClickListener {
            val layoutManager = speciesBinding.rvSpecies.layoutManager
            layoutManager?.scrollToPosition(mainViewModel.foundSpecies.value!!.size.minus(1))
        }

        speciesBinding.mbtnRandomSpecies.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.showRandomSpecies()
                mainViewModel.updateButtonStatesSpecies()
            }
        }

        speciesBinding.mbtnAZSpecies.backgroundTintList = getColorStateListSpecies()
        speciesBinding.mbtnAZSpecies.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.showSpeciesAtoZ()
            }
        }

        speciesBinding.mbtnZASpecies.backgroundTintList = getColorStateListSpecies()
        speciesBinding.mbtnZASpecies.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.showSpeciesZtoA()
            }
        }

        speciesAdapter = SpeciesAdapter(mainViewModel, viewLifecycleOwner)
        speciesBinding.rvSpecies.setHasFixedSize(true)
        speciesBinding.rvSpecies.layoutManager = LinearLayoutManager(requireContext())
        speciesBinding.rvSpecies.adapter = speciesAdapter
    }

    private fun initObservers() {
        mainViewModel.foundSpecies.observe(viewLifecycleOwner) { foundSpecies ->
            speciesAdapter.updateList(foundSpecies)
            if (foundSpecies.isEmpty()) {
                speciesBinding.mbtnGoTopSpecies.isEnabled = false
                speciesBinding.mbtnGoTopSpecies.backgroundTintList = getColorStateListSpecies()
                speciesBinding.mbtnGoDownSpecies.isEnabled = false
                speciesBinding.mbtnGoDownSpecies.backgroundTintList = getColorStateListSpecies()
                speciesBinding.mbtnAZSpecies.isEnabled = false
                speciesBinding.mbtnAZSpecies.backgroundTintList = getColorStateListSpecies()
                speciesBinding.mbtnZASpecies.isEnabled = false
                speciesBinding.mbtnZASpecies.backgroundTintList = getColorStateListSpecies()
            } else {
                speciesBinding.mbtnGoTopSpecies.isEnabled = true
                speciesBinding.mbtnGoTopSpecies.backgroundTintList = getColorStateListSpecies()
                speciesBinding.mbtnGoDownSpecies.isEnabled = true
                speciesBinding.mbtnGoDownSpecies.backgroundTintList = getColorStateListSpecies()
                speciesBinding.mbtnAZSpecies.isEnabled = true
                speciesBinding.mbtnAZSpecies.backgroundTintList = getColorStateListSpecies()
                speciesBinding.mbtnZASpecies.isEnabled = true
                speciesBinding.mbtnZASpecies.backgroundTintList = getColorStateListSpecies()
            }
        }

        mainViewModel.mbtnAllSpecies.observe(viewLifecycleOwner)
        { isEnabled ->
            speciesBinding.mbtnAllSpecies.isEnabled = isEnabled
            speciesBinding.mbtnAllSpecies.backgroundTintList = getColorStateListSpecies()
        }

        mainViewModel.mbtnFavSpecies.observe(viewLifecycleOwner)
        { isEnabled ->
            speciesBinding.mbtnFavSpecies.isEnabled = isEnabled
            speciesBinding.mbtnFavSpecies.backgroundTintList = getColorStateListSpecies()
        }
    }

    private fun getColorStateListSpecies(): ColorStateList {
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
        fun newInstance() = SpeciesFragment()
    }
}