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
import com.antelo97.harrypotterapp.databinding.ItemSpellBinding
import com.antelo97.harrypotterapp.domain.model.Spell
import com.antelo97.harrypotterapp.ui.viewmodel.MainViewModel
import com.squareup.picasso.Picasso
import kotlinx.coroutines.launch

class SpellsViewHolder(
    private val mainViewModel: MainViewModel,
    private val lifecycleOwner: LifecycleOwner,
    val view: View
) : RecyclerView.ViewHolder(view) {

    private val itemSpellBinding = ItemSpellBinding.bind(view)

    @SuppressLint("SetTextI18n")
    fun render(spell: Spell, position: Int) {
        itemSpellBinding.tvSpellName.text = spell.getName()
        itemSpellBinding.tvSpellDetails.text = spell.getDescription()
        Picasso.get().load(spell.getImageUrl()).into(itemSpellBinding.ivSpell)

        itemSpellBinding.ivSpellDetail.setOnClickListener {
            val isVisible = itemSpellBinding.tvSpellDetails.isVisible
            itemSpellBinding.tvSpellDetails.isVisible = !isVisible
            itemSpellBinding.ivSpellDetail.setImageResource(
                if (isVisible) R.drawable.ic_more_info else R.drawable.ic_less_info2
            )
            itemSpellBinding.llInfoSpell.setBackgroundColor(
                ContextCompat.getColor(
                    view.context,
                    if (isVisible) R.color.hp_light_brown_opacity_80 else R.color.hp_light_brown
                )
            )
        }

        itemSpellBinding.ivSpellFavorite.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.updateFavoriteSpell(spell, position)
                mainViewModel.updateButtonStatesSpells()
            }
        }

        initObservers(spell)
    }

    private fun initObservers(spell: Spell) {
        mainViewModel.foundSpells.observe(lifecycleOwner) {
            val color = if (spell.isFavorite) R.color.hp_gold else R.color.hp_white
            DrawableCompat.setTint(
                itemSpellBinding.ivSpellFavorite.drawable,
                ContextCompat.getColor(view.context, color)
            )
        }
    }
}