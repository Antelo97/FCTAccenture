package com.antelo97.harrypotterapp.ui.view

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.activity.viewModels
import androidx.appcompat.widget.SearchView
import com.antelo97.harrypotterapp.R
import com.antelo97.harrypotterapp.databinding.ActivityMainBinding
import com.antelo97.harrypotterapp.databinding.FragmentBooksBinding
import com.antelo97.harrypotterapp.databinding.FragmentCharactersBinding
import com.antelo97.harrypotterapp.databinding.FragmentSpeciesBinding
import com.antelo97.harrypotterapp.databinding.FragmentSpellsBinding
import com.antelo97.harrypotterapp.ui.view.fragment.BooksFragment
import com.antelo97.harrypotterapp.ui.view.fragment.CharactersFragment
import com.antelo97.harrypotterapp.ui.view.fragment.SpeciesFragment
import com.antelo97.harrypotterapp.ui.view.fragment.SpellsFragment
import com.antelo97.harrypotterapp.ui.viewmodel.MainViewModel
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class MainActivity : AppCompatActivity() {
    private lateinit var bindingMainActivity: ActivityMainBinding
    private lateinit var bindingBooksFragment: FragmentBooksBinding
    private lateinit var bindingCharactersFragment: FragmentCharactersBinding
    private lateinit var bindingSpellsFragment: FragmentSpellsBinding
    private lateinit var bindingSpeciesFragment: FragmentSpeciesBinding

    private val mainViewModel: MainViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        bindingMainActivity = ActivityMainBinding.inflate(layoutInflater)
        setContentView(bindingMainActivity.root)

        //bindingCharactersFragment = FragmentCharactersBinding.inflate(layoutInflater)
        //bindingSpellsFragment = FragmentSpellsBinding.inflate(layoutInflater)
        //bindingSpeciesFragment = FragmentSpeciesBinding.inflate(layoutInflater)

        initUI()
        mainViewModel.onCreate()
    }

    private fun initUI() {
        bindingMainActivity.bottomNavigationView.setOnNavigationItemSelectedListener { item ->
            when (item.itemId) {
                bindingMainActivity.bottomNavigationView.menu.getItem(0).itemId -> {
                    val fragment = BooksFragment.newInstance("param0", "param7")
                    supportFragmentManager.beginTransaction()
                        .replace(R.id.fragment_container, fragment)
                        .commit()
                    return@setOnNavigationItemSelectedListener true
                }
                R.id.toCharacters -> {
                    val fragment = CharactersFragment.newInstance("param1", "param2")
                    supportFragmentManager.beginTransaction()
                        .replace(R.id.fragment_container, fragment)
                        .commit()
                    return@setOnNavigationItemSelectedListener true
                }
                R.id.toSpells -> {
                    val fragment = SpellsFragment.newInstance("param1", "param2")
                    supportFragmentManager.beginTransaction()
                        .replace(R.id.fragment_container, fragment)
                        .commit()
                    return@setOnNavigationItemSelectedListener true
                }
                R.id.toSpecies -> {
                    val fragment = SpeciesFragment.newInstance("param1", "param2")
                    supportFragmentManager.beginTransaction()
                        .replace(R.id.fragment_container, fragment)
                        .commit()
                    return@setOnNavigationItemSelectedListener true
                }
            }
            false
        }

        bindingMainActivity.bottomNavigationView.selectedItemId = R.id.toBooks;
    }
}