package com.antelo97.harrypotterapp.ui.view.fragment.viewholder

import android.annotation.SuppressLint
import android.view.View
import android.widget.ImageView
import androidx.core.content.ContentProviderCompat.requireContext
import androidx.core.content.ContextCompat
import androidx.core.graphics.drawable.DrawableCompat
import androidx.core.view.isVisible
import androidx.lifecycle.viewModelScope
import androidx.recyclerview.widget.RecyclerView
import com.antelo97.harrypotterapp.R
import com.antelo97.harrypotterapp.databinding.ItemBookBinding
import com.antelo97.harrypotterapp.domain.model.Book
import com.antelo97.harrypotterapp.ui.viewmodel.MainViewModel
import com.squareup.picasso.Picasso
import kotlinx.coroutines.launch

class BooksViewHolder(
    val view: View,
    private val mainViewModel: MainViewModel
) : RecyclerView.ViewHolder(view) {

    private val binding = ItemBookBinding.bind(view)
    //val lifecycleOwner = binding.root.context as LifecycleOwner

    @SuppressLint("SetTextI18n")
    fun render(book: Book, position: Int) {
        binding.tvBookTitle.text = book.title
        binding.tvBookDetails.text =
            "\u2022 Author/-a: " + book.author + "\n" + "\u2022 Release date: " + book.releaseDate.substring(
                0,
                9
            )
        Picasso.get().load(book.imageUrl).into(binding.ivBook)

        if (book.isFavorite) {
            DrawableCompat.setTint(
                binding.ivBookFavorite.drawable,
                ContextCompat.getColor(view.context, R.color.hp_gold)
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

        binding.ivBookDetail.setOnClickListener {
            //binding.ivBook.scaleType = ImageView.ScaleType.FIT_XY
            if (!binding.tvBookDetails.isVisible) {
                binding.tvBookDetails.isVisible = true
                binding.ivBookDetail.setImageResource(R.drawable.ic_less_info2)
                binding.llInfoBook.setBackgroundColor(
                    ContextCompat.getColor(
                        view.context,
                        R.color.hp_light_brown
                    )
                )
            } else {
                binding.tvBookDetails.visibility = View.GONE
                binding.ivBookDetail.setImageResource(R.drawable.ic_more_info)
                binding.llInfoBook.setBackgroundColor(
                    ContextCompat.getColor(
                        view.context,
                        R.color.hp_light_brown_opacity_80
                    )
                )
            }
        }

        binding.ivBookFavorite.setOnClickListener {
            if (book.isFavorite) {
                DrawableCompat.setTint(
                    binding.ivBookFavorite.drawable,
                    ContextCompat.getColor(view.context, R.color.white)
                )
            } else {
                DrawableCompat.setTint(
                    binding.ivBookFavorite.drawable,
                    ContextCompat.getColor(view.context, R.color.hp_gold)
                )
            }

            mainViewModel.viewModelScope.launch {
                mainViewModel.updateFavoriteBook(book, position)
            }
        }
    }
}