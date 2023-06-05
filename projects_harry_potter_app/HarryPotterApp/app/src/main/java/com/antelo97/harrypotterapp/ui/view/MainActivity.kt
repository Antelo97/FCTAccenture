package com.antelo97.harrypotterapp.ui.view

import android.annotation.SuppressLint
import android.os.Bundle
import android.widget.Toast
import androidx.activity.viewModels
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.isVisible
import androidx.fragment.app.Fragment
import androidx.lifecycle.viewModelScope
import com.antelo97.harrypotterapp.R
import com.antelo97.harrypotterapp.databinding.ActivityMainBinding
import com.antelo97.harrypotterapp.ui.view.fragment.BooksFragment
import com.antelo97.harrypotterapp.ui.view.fragment.CharactersFragment
import com.antelo97.harrypotterapp.ui.view.fragment.SpeciesFragment
import com.antelo97.harrypotterapp.ui.view.fragment.SpellsFragment
import com.antelo97.harrypotterapp.ui.viewmodel.MainViewModel
import com.google.firebase.auth.FirebaseAuth
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

        val bundle: Bundle? = intent.extras
        val email = bundle!!.getString("email")
        mainViewModel.setEmail(email!!)

        initUI()
        initObservers()
    }

    @SuppressLint("ResourceType")
    private fun initUI() {
        mainBinding.bottomNavigationView.setOnNavigationItemSelectedListener { selectedItem ->
            mainViewModel.disabledIvMain()
            mainViewModel.disabledTvEmpyList()

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

        mainBinding.ivRemoveFavs.setOnClickListener {
            showRemoveFavsAlert()
        }

        mainBinding.ivLogOut.setOnClickListener {
            FirebaseAuth.getInstance().signOut()
            onBackPressed()
        }

        // Cargamos en la BD local toda la información de la API
        mainViewModel.viewModelScope.launch {
            mainViewModel.loadAllData()
        }
    }

    private fun initObservers() {
        mainViewModel.pbForActivity.observe(this) { isVisible ->
            mainBinding.pbForActivity.isVisible = isVisible
            mainBinding.viewLoadingMain.isVisible = isVisible
            for (item in 0 until mainBinding.bottomNavigationView.menu.size() - 1) {
                mainBinding.bottomNavigationView.menu.getItem(item).isEnabled = !isVisible
                mainBinding.bottomNavigationView.menu.getItem(item).isVisible = !isVisible
            }

            if (!isVisible) {
                mainBinding.bottomNavigationView.selectedItemId = R.id.toNothing
            }
        }

        mainViewModel.pbForFragments.observe(this) { isVisible ->
            mainBinding.pbForFragments.isVisible = isVisible
            mainBinding.viewLoadingMain.isVisible = isVisible
        }

        mainViewModel.ivMain.observe(this) { isVisible ->
            mainBinding.ivMain.isVisible = isVisible
            mainBinding.tvWelcome.isVisible = isVisible
        }

        mainViewModel.tvEmail.observe(this) { email ->
            mainBinding.tvUserEmail.text = email
        }

        mainViewModel.tvEmptyList.observe(this) { isVisible ->
            mainBinding.tvEmptyList.isVisible = isVisible
        }

        mainViewModel.foundBooks.observe(this) { foundBooks ->
            mainBinding.tvEmptyList.isVisible = foundBooks.isEmpty()
        }

        mainViewModel.foundCharacters.observe(this) { foundCharacters ->
            mainBinding.tvEmptyList.isVisible = foundCharacters.isEmpty()
        }

        mainViewModel.foundSpells.observe(this) { foundSpells ->
            mainBinding.tvEmptyList.isVisible = foundSpells.isEmpty()
        }

        mainViewModel.foundSpecies.observe(this) { foundSpecies ->
            mainBinding.tvEmptyList.isVisible = foundSpecies.isEmpty()
        }
    }

    private fun replaceFragment(fragment: Fragment) {
        supportFragmentManager.beginTransaction()
            .setCustomAnimations(android.R.anim.fade_in, android.R.anim.fade_out)
            .replace(mainBinding.fragmentContainer.id, fragment)
            .commit()
    }

    private fun showRemoveFavsAlert() {
        val builder: AlertDialog.Builder = AlertDialog.Builder(this)
        builder.setTitle("Remove favs")
        builder.setMessage("Are you sure you want to delete your favorites?")
        builder.setPositiveButton("Accept") { dialog, _ ->
            mainViewModel.viewModelScope.launch {
                mainViewModel.deleteFavBooks()
                mainViewModel.deleteFavCharacters()
                mainViewModel.deleteFavSpells()
                mainViewModel.deleteFavSpecies()
            }
            dialog.dismiss()
            Toast.makeText(this, "Favorites removed", Toast.LENGTH_SHORT).show()
        }
        builder.setNegativeButton("Cancel", null)
        val dialog: AlertDialog = builder.create()
        dialog.setCanceledOnTouchOutside(false)
        dialog.show()
    }
}