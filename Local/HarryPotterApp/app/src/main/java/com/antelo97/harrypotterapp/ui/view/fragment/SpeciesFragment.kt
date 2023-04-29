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
import com.antelo97.harrypotterapp.databinding.FragmentSpeciesBinding
import com.antelo97.harrypotterapp.ui.view.fragment.adapter.SpeciesAdapter
import com.antelo97.harrypotterapp.ui.viewmodel.MainViewModel
import kotlinx.coroutines.launch

class SpeciesFragment : Fragment() {
    private lateinit var bindingSpeciesFragment: FragmentSpeciesBinding
    private lateinit var speciesAdapter: SpeciesAdapter

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
        bindingSpeciesFragment = FragmentSpeciesBinding.inflate(inflater, container, false)
        initUI()
        return bindingSpeciesFragment.root
    }

    private fun initUI() {
        bindingSpeciesFragment.svSpecies.setOnQueryTextListener(object :
            SearchView.OnQueryTextListener {
            override fun onQueryTextSubmit(query: String?): Boolean {
                mainViewModel.searchSpeciesByName(query.orEmpty())
                return false
            }

            override fun onQueryTextChange(newText: String?) = false
        })

        bindingSpeciesFragment.mbtnFavSpecies.setOnClickListener {
            if (!bindingSpeciesFragment.mbtnAllSpecies.isEnabled) {
                mainViewModel.updateAllMBtnSpecies(false)
            }
            mainViewModel.viewModelScope.launch {
                mainViewModel.showFavoriteSpecies()
            }
        }

        bindingSpeciesFragment.mbtnAllSpecies.isEnabled =
            mainViewModel.mbtnAllSpecies.value ?: false
        bindingSpeciesFragment.mbtnAllSpecies.backgroundTintList = getColorStateListSpecies()
        bindingSpeciesFragment.mbtnAllSpecies.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.updateAllMBtnSpecies(it.isEnabled)
                mainViewModel.showAllSpecies()
            }
        }

        speciesAdapter = SpeciesAdapter(mainViewModel)
        bindingSpeciesFragment.rvSpecies.setHasFixedSize(true)
        bindingSpeciesFragment.rvSpecies.layoutManager = LinearLayoutManager(requireContext())
        bindingSpeciesFragment.rvSpecies.adapter = speciesAdapter
    }

    private fun initObservers() {
        mainViewModel.foundSpecies.observe(this) { foundSpecies ->
            speciesAdapter.updateList(foundSpecies)
        }

        mainViewModel.isLoadingSpecies.observe(this) { isLoadingSpecies ->
            bindingSpeciesFragment.pbSpecies.isVisible = isLoadingSpecies
        }

        mainViewModel.mbtnAllSpecies.observe(this) { mbtnAllSpecies ->
            bindingSpeciesFragment.mbtnAllSpecies.isEnabled = mbtnAllSpecies
            bindingSpeciesFragment.mbtnAllSpecies.backgroundTintList = getColorStateListSpecies()
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