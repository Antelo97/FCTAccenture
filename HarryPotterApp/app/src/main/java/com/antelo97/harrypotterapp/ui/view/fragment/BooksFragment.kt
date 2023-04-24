package com.antelo97.harrypotterapp.ui.view.fragment

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.appcompat.widget.SearchView
import androidx.core.content.ContextCompat
import androidx.core.graphics.drawable.DrawableCompat
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

// TODO: Rename parameter arguments, choose names that match
// the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
private const val ARG_PARAM1 = "param1"
private const val ARG_PARAM2 = "param2"

/**
 * A simple [Fragment] subclass.
 * Use the [BooksFragment.newInstance] factory method to
 * create an instance of this fragment.
 */
class BooksFragment : Fragment() {
    private lateinit var bindingBooksFragment: FragmentBooksBinding
    private lateinit var booksAdapter: BooksAdapter

    private val mainViewModel: MainViewModel by activityViewModels()

    private var param1: String? = null
    private var param2: String? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        bindingBooksFragment = FragmentBooksBinding.inflate(layoutInflater)

        arguments?.let {
            param1 = it.getString(ARG_PARAM1)
            param2 = it.getString(ARG_PARAM2)
        }

        mainViewModel.foundBooks.observe(this, Observer { foundBooks ->
            booksAdapter.updateList(foundBooks)
        })

        mainViewModel.isLoadingBooks.observe(this, Observer { isLoadingBooks ->
            bindingBooksFragment.pbBooks.isVisible = isLoadingBooks
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

        bindingBooksFragment.fabFav.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.showFavoriteBooks()
                Log.d("TAG", "Este es un mensaje de depuración");
            }
        }

        booksAdapter = BooksAdapter(mainViewModel)
        bindingBooksFragment.rvBooks.setHasFixedSize(true)
        bindingBooksFragment.rvBooks.layoutManager = LinearLayoutManager(requireContext())
        bindingBooksFragment.rvBooks.adapter = booksAdapter
    }

    companion object {
        /**
         * Use this factory method to create a new instance of
         * this fragment using the provided parameters.
         *
         * @param param1 Parameter 1.
         * @param param2 Parameter 2.
         * @return A new instance of fragment BooksFragment.
         */
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance(param1: String, param2: String) =
            BooksFragment().apply {
                arguments = Bundle().apply {
                    putString(ARG_PARAM1, param1)
                    putString(ARG_PARAM2, param2)
                }
            }
    }
}