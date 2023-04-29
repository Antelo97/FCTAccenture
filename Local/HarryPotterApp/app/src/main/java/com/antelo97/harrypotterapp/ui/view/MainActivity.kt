package com.antelo97.harrypotterapp.ui.view

import android.annotation.SuppressLint
import android.os.Bundle
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.isVisible
import androidx.fragment.app.Fragment
import androidx.lifecycle.viewModelScope
import com.antelo97.harrypotterapp.R
import com.antelo97.harrypotterapp.databinding.ActivityMainBinding
import com.antelo97.harrypotterapp.domain.model.Species
import com.antelo97.harrypotterapp.ui.view.fragment.BooksFragment
import com.antelo97.harrypotterapp.ui.view.fragment.CharactersFragment
import com.antelo97.harrypotterapp.ui.view.fragment.SpeciesFragment
import com.antelo97.harrypotterapp.ui.view.fragment.SpellsFragment
import com.antelo97.harrypotterapp.ui.viewmodel.MainViewModel
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.launch


@Suppress("DEPRECATION")
@AndroidEntryPoint
class MainActivity : AppCompatActivity() {
    private lateinit var mainBinding: ActivityMainBinding

    private val mainViewModel: MainViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        mainBinding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(mainBinding.root)

        initUI()
        initObservers()
    }

    @SuppressLint("ResourceType")
    private fun initUI() {
        mainBinding.bottomNavigationView.setOnNavigationItemSelectedListener { selectedItem ->
            mainViewModel.disabledIvMain()

            when (selectedItem.itemId) {
                mainBinding.bottomNavigationView.menu.getItem(0).itemId -> {
                    replaceFragment(BooksFragment.newInstance())
                    return@setOnNavigationItemSelectedListener true
                }
                R.id.toCharacters -> {
                    replaceFragment(CharactersFragment.newInstance())
                    return@setOnNavigationItemSelectedListener true
                }
                R.id.toSpells -> {
                    replaceFragment(SpellsFragment.newInstance())
                    return@setOnNavigationItemSelectedListener true
                }
                R.id.toSpecies -> {
                    replaceFragment(SpeciesFragment.newInstance())
                    return@setOnNavigationItemSelectedListener true
                }
            }
            false
        }

        // Cargamos en la BD local toda la información de la API
        mainViewModel.viewModelScope.launch {
            mainViewModel.loadAllData()
            mainBinding.bottomNavigationView.selectedItemId = R.id.toNothing
        }
    }

    private fun initObservers() {
        mainViewModel.pbMain.observe(this) { isVisible ->
            mainBinding.pbMain.isVisible = isVisible
            mainBinding.viewLoadingMain.isVisible = isVisible
            for (item in 0 until mainBinding.bottomNavigationView.menu.size() - 1) {
                mainBinding.bottomNavigationView.menu.getItem(item).isEnabled = !isVisible
                mainBinding.bottomNavigationView.menu.getItem(item).isVisible = !isVisible
            }
        }

        mainViewModel.ivMain.observe(this) { isVisible ->
            mainBinding.ivMain.isVisible = isVisible
        }
    }

    private fun replaceFragment(fragment: Fragment) {
        supportFragmentManager.beginTransaction()
            .setCustomAnimations(android.R.anim.fade_in, android.R.anim.fade_out)
            .replace(mainBinding.fragmentContainer.id, fragment)
            .commit()
    }
}