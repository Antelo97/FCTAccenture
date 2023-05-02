package com.antelo97.harrypotterapp.ui.view.fragment.viewholder

import android.annotation.SuppressLint
import android.view.View
import androidx.core.content.ContextCompat
import androidx.core.graphics.drawable.DrawableCompat
import androidx.core.view.isVisible
import androidx.lifecycle.viewModelScope
import androidx.recyclerview.widget.RecyclerView
import com.antelo97.harrypotterapp.R
import com.antelo97.harrypotterapp.databinding.ItemBookBinding
import com.antelo97.harrypotterapp.databinding.ItemSpellBinding
import com.antelo97.harrypotterapp.domain.model.Spell
import com.antelo97.harrypotterapp.ui.viewmodel.MainViewModel
import com.squareup.picasso.Picasso
import kotlinx.coroutines.launch

class SpellsViewHolder(
    val view: View,
    private val mainViewModel: MainViewModel,
) : RecyclerView.ViewHolder(view) {

    @SuppressLint("SetTextI18n")
    private val binding = ItemSpellBinding.bind(view)

    fun render(spell: Spell, position: Int) {
        binding.tvSpellName.text = spell.name
        binding.tvSpellDetails.text = spell.description
        Picasso.get().load(spell.imageUrl).into(binding.ivSpell)

        if (spell.isFavorite) {
            DrawableCompat.setTint(
                binding.ivSpellFavorite.drawable,
                ContextCompat.getColor(view.context, R.color.hp_gold)
            )
        } else {
            DrawableCompat.setTint(
                binding.ivSpellFavorite.drawable,
                ContextCompat.getColor(view.context, R.color.white)
            )
        }

        binding.ivSpellDetail.setOnClickListener {
            if (!binding.tvSpellDetails.isVisible) {
                binding.tvSpellDetails.isVisible = true
                binding.ivSpellDetail.setImageResource(R.drawable.ic_less_info2)
                binding.llInfoSpell.setBackgroundColor(
                    ContextCompat.getColor(
                        view.context,
                        R.color.hp_light_brown
                    )
                )
            } else {
                binding.tvSpellDetails.visibility = View.GONE
                binding.ivSpellDetail.setImageResource(R.drawable.ic_more_info)
                binding.llInfoSpell.setBackgroundColor(
                    ContextCompat.getColor(
                        view.context,
                        R.color.hp_light_brown_opacity_80
                    )
                )
            }
        }

        binding.ivSpellFavorite.setOnClickListener {
            if (spell.isFavorite) {
                DrawableCompat.setTint(
                    binding.ivSpellFavorite.drawable,
                    ContextCompat.getColor(view.context, R.color.white)
                )
            } else {
                DrawableCompat.setTint(
                    binding.ivSpellFavorite.drawable,
                    ContextCompat.getColor(view.context, R.color.hp_gold)
                )
            }

            mainViewModel.viewModelScope.launch {
                mainViewModel.updateFavoriteSpell(spell, position)
            }
        }
    }
}