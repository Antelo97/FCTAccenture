package com.antelo97.harrypotterapp.ui.view.fragment.viewholder

import android.view.View
import androidx.core.content.ContextCompat
import androidx.core.graphics.drawable.DrawableCompat
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.Observer
import androidx.lifecycle.viewModelScope
import androidx.recyclerview.widget.RecyclerView
import com.antelo97.harrypotterapp.R
import com.antelo97.harrypotterapp.databinding.ItemBookBinding
import com.antelo97.harrypotterapp.domain.model.Book
import com.antelo97.harrypotterapp.ui.viewmodel.MainViewModel
import com.squareup.picasso.Picasso
import kotlinx.coroutines.launch

class BooksViewHolder(val view: View, private val mainViewModel: MainViewModel) :
    RecyclerView.ViewHolder(view) {

    private val binding = ItemBookBinding.bind(view)
    val lifecycleOwner = binding.root.context as LifecycleOwner

    fun render(book: Book, position: Int) {
        binding.tvBookTitle.text = book.title
        Picasso.get().load(book.imageUrl).into(binding.ivBook)

        if (book.isFavorite) {
            DrawableCompat.setTint(
                binding.ivBookFavorite.drawable,
                ContextCompat.getColor(view.context, R.color.hp_oro)
            )
        } else {
            DrawableCompat.setTint(
                binding.ivBookFavorite.drawable,
                ContextCompat.getColor(view.context, R.color.white)
            )
        }

        /*mainViewModel.favoriteList[position].observe(lifecycleOwner, Observer { color ->
            DrawableCompat.setTint(binding.ivBookFavorite.drawable, color)
        })*/

        binding.ivBookFavorite.setOnClickListener {
            if (book.isFavorite) {
                DrawableCompat.setTint(
                    binding.ivBookFavorite.drawable,
                    ContextCompat.getColor(view.context, R.color.white)
                )
            } else {
                DrawableCompat.setTint(
                    binding.ivBookFavorite.drawable,
                    ContextCompat.getColor(view.context, R.color.hp_oro)
                )
            }

            mainViewModel.viewModelScope.launch {
                mainViewModel.updateFavoriteBook(book, position)
            }
        }
    }
}