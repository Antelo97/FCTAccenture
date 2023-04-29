package com.antelo97.harrypotterapp.ui.view.fragment.viewholder

import android.view.View
import androidx.core.content.ContextCompat
import androidx.core.graphics.drawable.DrawableCompat
import androidx.core.view.isVisible
import androidx.lifecycle.viewModelScope
import androidx.recyclerview.widget.RecyclerView
import com.antelo97.harrypotterapp.R
import com.antelo97.harrypotterapp.databinding.ItemSpeciesBinding
import com.antelo97.harrypotterapp.domain.model.Species
import com.antelo97.harrypotterapp.ui.viewmodel.MainViewModel
import com.squareup.picasso.Picasso
import kotlinx.coroutines.launch
import java.text.FieldPosition

class SpeciesViewHolder(
    private val mainViewModel: MainViewModel,
    val view: View
) : RecyclerView.ViewHolder(view) {

    private val binding = ItemSpeciesBinding.bind(view)

    fun render(species: Species, position: Int) {
        binding.tvSpeciesName.text = species.name
        binding.tvSpeciesDetails.text = species.native_
        Picasso.get().load(species.imageUrl).into(binding.ivSpecies)

        if (species.isFavorite) {
            DrawableCompat.setTint(
                binding.ivSpeciesFavorite.drawable,
                ContextCompat.getColor(view.context, R.color.hp_gold)
            )
        } else {
            DrawableCompat.setTint(
                binding.ivSpeciesFavorite.drawable,
                ContextCompat.getColor(view.context, R.color.hp_white)
            )
        }

        binding.ivSpeciesDetail.setOnClickListener {
            if (!binding.tvSpeciesDetails.isVisible) {
                binding.tvSpeciesDetails.isVisible = true
                binding.ivSpeciesDetail.setImageResource(R.drawable.ic_less_info2)
                binding.llInfoSpecies.setBackgroundColor(
                    ContextCompat.getColor(
                        view.context,
                        R.color.hp_light_brown
                    )
                )
            } else {
                binding.tvSpeciesDetails.visibility = View.GONE
                binding.ivSpeciesDetail.setImageResource(R.drawable.ic_more_info)
                binding.llInfoSpecies.setBackgroundColor(
                    ContextCompat.getColor(
                        view.context,
                        R.color.hp_light_brown_opacity_80
                    )
                )
            }
        }

        binding.ivSpeciesFavorite.setOnClickListener {
            if (species.isFavorite) {
                DrawableCompat.setTint(
                    binding.ivSpeciesFavorite.drawable,
                    ContextCompat.getColor(view.context, R.color.white)
                )
            } else {
                DrawableCompat.setTint(
                    binding.ivSpeciesFavorite.drawable,
                    ContextCompat.getColor(view.context, R.color.hp_gold)
                )
            }

            mainViewModel.viewModelScope.launch {
                mainViewModel.updateFavoriteSpecies(species, position)
            }
        }
    }
}