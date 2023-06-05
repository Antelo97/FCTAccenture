package com.antelo97.harrypotterapp.ui.view.fragment.adapter

import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.LifecycleOwner
import androidx.recyclerview.widget.RecyclerView
import com.antelo97.harrypotterapp.R
import com.antelo97.harrypotterapp.domain.model.Book
import com.antelo97.harrypotterapp.ui.view.fragment.viewholder.BooksViewHolder
import com.antelo97.harrypotterapp.ui.viewmodel.MainViewModel

class BooksAdapter(
    private val mainViewModel: MainViewModel,
    private val lifecycleOwner: LifecycleOwner,
    var foundBooks: List<Book> = emptyList()
) : RecyclerView.Adapter<BooksViewHolder>() {

    @SuppressLint("NotifyDataSetChanged")
    fun updateList(foundBooks: List<Book>) {
        this.foundBooks = foundBooks
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): BooksViewHolder {
        val layoutInflater: LayoutInflater = LayoutInflater.from(parent.context)
        val view: View = layoutInflater.inflate(R.layout.item_book, parent, false)
        return BooksViewHolder(mainViewModel, lifecycleOwner, view)
    }

    override fun getItemCount() = foundBooks.size

    override fun onBindViewHolder(viewHolder: BooksViewHolder, position: Int) {
        viewHolder.render(foundBooks[position], position)
    }
}