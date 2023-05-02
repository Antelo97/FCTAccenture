package com.antelo97.harrypotterapp.ui.view.fragment.viewholder

import android.annotation.SuppressLint
import android.view.View
import androidx.core.content.ContextCompat
import androidx.core.graphics.drawable.DrawableCompat
import androidx.core.view.isVisible
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.viewModelScope
import androidx.recyclerview.widget.RecyclerView
import com.antelo97.harrypotterapp.R
import com.antelo97.harrypotterapp.databinding.ItemBookBinding
import com.antelo97.harrypotterapp.domain.model.Book
import com.antelo97.harrypotterapp.ui.viewmodel.MainViewModel
import com.squareup.picasso.Picasso
import kotlinx.coroutines.launch

class BooksViewHolder(
    private val mainViewModel: MainViewModel,
    private val lifecycleOwner: LifecycleOwner,
    val view: View
) : RecyclerView.ViewHolder(view) {

    private val itemBookBinding = ItemBookBinding.bind(view)

    @SuppressLint("SetTextI18n")
    fun render(book: Book, position: Int) {
        itemBookBinding.tvBookTitle.text = book.title
        itemBookBinding.tvBookDetails.text =
            "\u2022 Author/-a: ${book.author}" +
                    "\n\u2022 Release date: ${book.releaseDate.substring(0, 9)}"
        Picasso.get().load(book.imageUrl).into(itemBookBinding.ivBook)

        itemBookBinding.ivBookDetail.setOnClickListener {
            val isVisible = itemBookBinding.tvBookDetails.isVisible
            itemBookBinding.tvBookDetails.isVisible = !isVisible
            itemBookBinding.ivBookDetail.setImageResource(
                if (isVisible) R.drawable.ic_more_info else R.drawable.ic_less_info2
            )
            itemBookBinding.llInfoBook.setBackgroundColor(
                ContextCompat.getColor(
                    view.context,
                    if (isVisible) R.color.hp_light_brown_opacity_80 else R.color.hp_light_brown
                )
            )
        }

        itemBookBinding.ivBookFavorite.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.updateFavoriteBook(book, position)
                mainViewModel.updateButtonStatesBook()
            }
        }

        initObservers(book)
    }

    fun initObservers(book: Book) {
        mainViewModel.foundBooks.observe(lifecycleOwner) {
            val color = if (book.isFavorite) R.color.hp_gold else R.color.hp_white
            DrawableCompat.setTint(
                itemBookBinding.ivBookFavorite.drawable,
                ContextCompat.getColor(view.context, color)
            )
        }
    }
}