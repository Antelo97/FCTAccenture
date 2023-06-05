package com.antelo97.harrypotterapp.ui.view.fragment

import android.content.res.ColorStateList
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.appcompat.widget.SearchView
import androidx.core.content.ContextCompat
import androidx.fragment.app.activityViewModels
import androidx.lifecycle.viewModelScope
import androidx.recyclerview.widget.LinearLayoutManager
import com.antelo97.harrypotterapp.R
import com.antelo97.harrypotterapp.databinding.FragmentBooksBinding
import com.antelo97.harrypotterapp.ui.view.fragment.adapter.BooksAdapter
import com.antelo97.harrypotterapp.ui.viewmodel.MainViewModel
import kotlinx.coroutines.launch

class BooksFragment : Fragment() {
    private lateinit var booksBinding: FragmentBooksBinding
    private lateinit var booksAdapter: BooksAdapter

    private val mainViewModel: MainViewModel by activityViewModels()

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        booksBinding = FragmentBooksBinding.inflate(inflater, container, false)
        initUI()
        initObservers()
        return booksBinding.root
    }

    private fun initUI() {
        mainViewModel.updateTvEmpyList(mainViewModel.foundBooks.value!!.size)

        booksBinding.svBooks.setOnQueryTextListener(object :
            SearchView.OnQueryTextListener {
            override fun onQueryTextSubmit(query: String?): Boolean {
                mainViewModel.viewModelScope.launch {
                    mainViewModel.searchBooksByTitle(query.orEmpty())
                    mainViewModel.updateButtonStatesBook()
                }
                return false
            }

            override fun onQueryTextChange(newText: String?) = false
        })

        booksBinding.mbtnFavBooks.backgroundTintList = getColorStateListBooks()
        booksBinding.mbtnFavBooks.setOnClickListener {
            //Toast.makeText(requireContext(), "Mensaje flotante", Toast.LENGTH_SHORT).show()
            mainViewModel.viewModelScope.launch {
                mainViewModel.showFavoriteBooks()
                mainViewModel.updateButtonStatesBook()
            }
        }

        booksBinding.mbtnAllBooks.backgroundTintList = getColorStateListBooks()
        booksBinding.mbtnAllBooks.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.showAllBooks()
                mainViewModel.updateButtonStatesBook()
            }
        }

        booksBinding.mbtnGoTopBooks.backgroundTintList = getColorStateListBooks()
        booksBinding.mbtnGoTopBooks.setOnClickListener {
            val layoutManager = booksBinding.rvBooks.layoutManager
            layoutManager?.scrollToPosition(0)
        }

        booksBinding.mbtnGoDownBooks.backgroundTintList = getColorStateListBooks()
        booksBinding.mbtnGoDownBooks.setOnClickListener {
            val layoutManager = booksBinding.rvBooks.layoutManager
            layoutManager?.scrollToPosition(mainViewModel.foundBooks.value!!.size.minus(1))
        }

        booksBinding.mbtnRandomBook.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.showRandomBook()
                mainViewModel.updateButtonStatesBook()
            }
        }

        booksBinding.mbtnAZBooks.backgroundTintList = getColorStateListBooks()
        booksBinding.mbtnAZBooks.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.showBooksAtoZ()
            }
        }

        booksBinding.mbtnZABooks.backgroundTintList = getColorStateListBooks()
        booksBinding.mbtnZABooks.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.showBooksZtoA()
            }
        }

        booksAdapter = BooksAdapter(mainViewModel, viewLifecycleOwner)
        booksBinding.rvBooks.setHasFixedSize(true)
        booksBinding.rvBooks.layoutManager = LinearLayoutManager(requireContext())
        booksBinding.rvBooks.adapter = booksAdapter
    }

    private fun initObservers() {
        mainViewModel.foundBooks.observe(viewLifecycleOwner) { foundBooks ->
            booksAdapter.updateList(foundBooks)
            if (foundBooks.isEmpty()) {
                booksBinding.mbtnGoTopBooks.isEnabled = false
                booksBinding.mbtnGoTopBooks.backgroundTintList = getColorStateListBooks()
                booksBinding.mbtnGoDownBooks.isEnabled = false
                booksBinding.mbtnGoDownBooks.backgroundTintList = getColorStateListBooks()
                booksBinding.mbtnAZBooks.apply {
                    isEnabled = false
                    backgroundTintList = getColorStateListBooks()
                }
                booksBinding.mbtnAZBooks.isEnabled = false
                booksBinding.mbtnAZBooks.backgroundTintList = getColorStateListBooks()
                booksBinding.mbtnZABooks.isEnabled = false
                booksBinding.mbtnZABooks.backgroundTintList = getColorStateListBooks()
            } else {
                booksBinding.mbtnGoTopBooks.isEnabled = true
                booksBinding.mbtnGoTopBooks.backgroundTintList = getColorStateListBooks()
                booksBinding.mbtnGoDownBooks.isEnabled = true
                booksBinding.mbtnGoDownBooks.backgroundTintList = getColorStateListBooks()
                booksBinding.mbtnAZBooks.isEnabled = true
                booksBinding.mbtnAZBooks.backgroundTintList = getColorStateListBooks()
                booksBinding.mbtnZABooks.isEnabled = true
                booksBinding.mbtnZABooks.backgroundTintList = getColorStateListBooks()
            }
        }

        mainViewModel.mbtnAllBooks.observe(viewLifecycleOwner) { isEnabled ->
            booksBinding.mbtnAllBooks.isEnabled = isEnabled
            booksBinding.mbtnAllBooks.backgroundTintList = getColorStateListBooks()
        }

        mainViewModel.mbtnFavBooks.observe(viewLifecycleOwner) { isEnabled ->
            booksBinding.mbtnFavBooks.isEnabled = isEnabled
            booksBinding.mbtnFavBooks.backgroundTintList = getColorStateListBooks()
        }
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
        @JvmStatic
        fun newInstance() = BooksFragment()
    }
}