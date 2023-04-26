package com.antelo97.harrypotterapp.ui.view.fragment

import android.content.res.ColorStateList
import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.appcompat.widget.SearchView
import androidx.core.content.ContextCompat
import androidx.core.view.isVisible
import androidx.fragment.app.activityViewModels
import androidx.lifecycle.Observer
import androidx.lifecycle.viewModelScope
import androidx.recyclerview.widget.LinearLayoutManager
import com.antelo97.harrypotterapp.R
import com.antelo97.harrypotterapp.databinding.FragmentBooksBinding
import com.antelo97.harrypotterapp.ui.view.fragment.adapter.BooksAdapter
import com.antelo97.harrypotterapp.ui.viewmodel.MainViewModel
import kotlinx.coroutines.launch

/**
 * A simple [Fragment] subclass.
 * Use the [BooksFragment.newInstance] factory method to
 * create an instance of this fragment.
 */
class BooksFragment : Fragment() {
    private lateinit var bindingBooksFragment: FragmentBooksBinding
    private lateinit var booksAdapter: BooksAdapter

    private val mainViewModel: MainViewModel by activityViewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        //bindingBooksFragment = FragmentBooksBinding.inflate(layoutInflater)

        // Observers
        mainViewModel.foundBooks.observe(this, Observer { foundBooks ->
            booksAdapter.updateList(foundBooks)
        })

        mainViewModel.isLoadingBooks.observe(this, Observer { isLoadingBooks ->
            bindingBooksFragment.pbBooks.isVisible = isLoadingBooks
        })

        mainViewModel.mbtnAllBooks.observe(this, Observer { mbtnAllBook ->
            bindingBooksFragment.mbtnAllBooks.isEnabled = mbtnAllBook

            // Asigna la lista de colores al backgroundTint del botón
            bindingBooksFragment.mbtnAllBooks.backgroundTintList = getColorStateListBooks()
            Log.d("A", "HOLAAAA")
        })
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        bindingBooksFragment = FragmentBooksBinding.inflate(inflater, container, false)
        initUI()
        return bindingBooksFragment.root
    }

    private fun initUI() {
        bindingBooksFragment.svBooks.setOnQueryTextListener(object :
            SearchView.OnQueryTextListener {
            override fun onQueryTextSubmit(query: String?): Boolean {
                mainViewModel.searchBooksByTitle(query.orEmpty())
                return false
            }

            override fun onQueryTextChange(newText: String?) = false
        })

        bindingBooksFragment.mbtnFavBooks.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                if (!bindingBooksFragment.mbtnAllBooks.isEnabled) {
                    mainViewModel.updateAllMBtnBook(bindingBooksFragment.mbtnAllBooks.isEnabled)
                }
                mainViewModel.showFavoriteBooks()
            }
        }

        bindingBooksFragment.mbtnAllBooks.isEnabled = mainViewModel.mbtnAllBooks.value ?: true
        bindingBooksFragment.mbtnAllBooks.backgroundTintList = getColorStateListBooks()
        bindingBooksFragment.mbtnAllBooks.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.updateAllMBtnBook(it.isEnabled)
                mainViewModel.showAllBooks()
            }
        }

        booksAdapter = BooksAdapter(mainViewModel)
        bindingBooksFragment.rvBooks.setHasFixedSize(true)
        bindingBooksFragment.rvBooks.layoutManager = LinearLayoutManager(requireContext())
        bindingBooksFragment.rvBooks.adapter = booksAdapter
    }

    private fun getColorStateListBooks(): ColorStateList {
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
        /**
         * Use this factory method to create a new instance of
         * this fragment.
         */
        @JvmStatic
        fun newInstance() = BooksFragment()
    }
}