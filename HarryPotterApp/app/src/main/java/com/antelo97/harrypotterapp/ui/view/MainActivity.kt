package com.antelo97.harrypotterapp.ui.view

import android.animation.AnimatorInflater
import android.animation.AnimatorSet
import android.annotation.SuppressLint
import android.os.Bundle
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.isVisible
import androidx.lifecycle.Observer
import androidx.lifecycle.viewModelScope
import com.antelo97.harrypotterapp.R
import com.antelo97.harrypotterapp.databinding.ActivityMainBinding
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
    private lateinit var bindingMainActivity: ActivityMainBinding

    private val mainViewModel: MainViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        bindingMainActivity = ActivityMainBinding.inflate(layoutInflater)
        setContentView(bindingMainActivity.root)

        initUI()

        // Observers
        mainViewModel.isLoadingMain.observe(this, Observer { isLoadingMain ->
            bindingMainActivity.pbLoadingMain.isVisible = isLoadingMain
            bindingMainActivity.viewLoadingMain.isVisible = isLoadingMain
            bindingMainActivity.bottomNavigationView.menu.getItem(0).isEnabled = !isLoadingMain
            bindingMainActivity.bottomNavigationView.menu.getItem(1).isEnabled = !isLoadingMain
            bindingMainActivity.bottomNavigationView.menu.getItem(2).isEnabled = !isLoadingMain
            bindingMainActivity.bottomNavigationView.menu.getItem(3).isEnabled = !isLoadingMain
            bindingMainActivity.bottomNavigationView.menu.getItem(0).isVisible = !isLoadingMain
            bindingMainActivity.bottomNavigationView.menu.getItem(1).isVisible = !isLoadingMain
            bindingMainActivity.bottomNavigationView.menu.getItem(2).isVisible = !isLoadingMain
            bindingMainActivity.bottomNavigationView.menu.getItem(3).isVisible = !isLoadingMain
        })
    }

    @SuppressLint("ResourceType")
    private fun initUI() {
        // Definición de eventos
        bindingMainActivity.bottomNavigationView.setOnNavigationItemSelectedListener { item ->
            when (item.itemId) {
                bindingMainActivity.bottomNavigationView.menu.getItem(0).itemId -> {
                    val booksFragment: BooksFragment = BooksFragment.newInstance()
                    supportFragmentManager.beginTransaction()
                        .setCustomAnimations(android.R.anim.fade_in, android.R.anim.fade_out)
                        .replace(bindingMainActivity.fragmentContainer.id, booksFragment)
                        .commit()
                    return@setOnNavigationItemSelectedListener true
                }
                R.id.toCharacters -> {
                    val charactersFragment = CharactersFragment.newInstance()
                    supportFragmentManager.beginTransaction()
                        .setCustomAnimations(android.R.anim.fade_in, android.R.anim.fade_out)
                        .replace(R.id.fragmentContainer, charactersFragment)
                        .commit()
                    return@setOnNavigationItemSelectedListener true
                }
                bindingMainActivity.bottomNavigationView.menu.getItem(2).itemId -> {
                    val spellsFragment = SpellsFragment.newInstance()
                    supportFragmentManager.beginTransaction()
                        .setCustomAnimations(android.R.anim.fade_in, android.R.anim.fade_out)
                        .replace(bindingMainActivity.fragmentContainer.id, spellsFragment)
                        .commit()
                    return@setOnNavigationItemSelectedListener true
                }
                R.id.toSpecies -> {
                    val speciesFragment = SpeciesFragment.newInstance()
                    supportFragmentManager.beginTransaction()
                        .setCustomAnimations(android.R.anim.fade_in, android.R.anim.fade_out)
                        .replace(R.id.fragmentContainer, speciesFragment)
                        .commit()
                    return@setOnNavigationItemSelectedListener true
                }
            }
            false
        }

        // Definición de atributos
        bindingMainActivity.pbLoadingMain.isVisible = mainViewModel.isLoadingMain.value ?: true
        bindingMainActivity.viewLoadingMain.isVisible = mainViewModel.isLoadingMain.value ?: true
        bindingMainActivity.bottomNavigationView.menu.getItem(0).isEnabled =
            !(mainViewModel.isLoadingMain.value ?: true)
        bindingMainActivity.bottomNavigationView.menu.getItem(1).isEnabled =
            !(mainViewModel.isLoadingMain.value ?: true)
        bindingMainActivity.bottomNavigationView.menu.getItem(2).isEnabled =
            !(mainViewModel.isLoadingMain.value ?: true)
        bindingMainActivity.bottomNavigationView.menu.getItem(3).isEnabled =
            !(mainViewModel.isLoadingMain.value ?: true)
        bindingMainActivity.bottomNavigationView.menu.getItem(0).isVisible =
            !(mainViewModel.isLoadingMain.value ?: true)
        bindingMainActivity.bottomNavigationView.menu.getItem(1).isVisible =
            !(mainViewModel.isLoadingMain.value ?: true)
        bindingMainActivity.bottomNavigationView.menu.getItem(2).isVisible =
            !(mainViewModel.isLoadingMain.value ?: true)
        bindingMainActivity.bottomNavigationView.menu.getItem(3).isVisible =
            !(mainViewModel.isLoadingMain.value ?: true)

        // Cargamos en la BD local toda la información de la API
        mainViewModel.viewModelScope.launch {
            mainViewModel.loadAllData()
            bindingMainActivity.bottomNavigationView.selectedItemId = R.id.toBooks
        }
    }
}