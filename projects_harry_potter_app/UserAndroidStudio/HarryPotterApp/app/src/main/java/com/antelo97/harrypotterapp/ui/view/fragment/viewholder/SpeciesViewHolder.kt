package com.antelo97.harrypotterapp.ui.view.fragment.viewholder

import android.view.View
import androidx.core.content.ContextCompat
import androidx.core.graphics.drawable.DrawableCompat
import androidx.core.view.isVisible
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.viewModelScope
import androidx.recyclerview.widget.RecyclerView
import com.antelo97.harrypotterapp.R
import com.antelo97.harrypotterapp.databinding.ItemSpeciesBinding
import com.antelo97.harrypotterapp.domain.model.Species
import com.antelo97.harrypotterapp.ui.viewmodel.MainViewModel
import com.squareup.picasso.Picasso
import kotlinx.coroutines.launch

class SpeciesViewHolder(
    private val mainViewModel: MainViewModel,
    private val lifecycleOwner: LifecycleOwner,
    val view: View
) : RecyclerView.ViewHolder(view) {

    private val itemSpeciesBinding = ItemSpeciesBinding.bind(view)

    fun render(species: Species, position: Int) {
        itemSpeciesBinding.tvSpeciesName.text = species.getName()
        itemSpeciesBinding.tvSpeciesDetails.text = species.getNative()
        Picasso.get().load(species.getImageUrl()).into(itemSpeciesBinding.ivSpecies)

        itemSpeciesBinding.ivSpeciesDetail.setOnClickListener {
            val isVisible = itemSpeciesBinding.tvSpeciesDetails.isVisible
            itemSpeciesBinding.tvSpeciesDetails.isVisible = !isVisible
            itemSpeciesBinding.ivSpeciesDetail.setImageResource(
                if (isVisible) R.drawable.ic_more_info else R.drawable.ic_less_info2
            )
            itemSpeciesBinding.llInfoSpecies.setBackgroundColor(
                ContextCompat.getColor(
                    view.context,
                    if (isVisible) R.color.hp_light_brown_opacity_80 else R.color.hp_light_brown
                )
            )
        }

        itemSpeciesBinding.ivSpeciesFavorite.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.updateFavoriteSpecies(species, position)
                mainViewModel.updateButtonStatesSpecies()
            }
        }

        initObservers(species)
    }

    private fun initObservers(species: Species) {
        val color = if (species.isFavorite) R.color.hp_gold else R.color.hp_white
        DrawableCompat.setTint(
            itemSpeciesBinding.ivSpeciesFavorite.drawable,
            ContextCompat.getColor(view.context, color)
        )
    }
}