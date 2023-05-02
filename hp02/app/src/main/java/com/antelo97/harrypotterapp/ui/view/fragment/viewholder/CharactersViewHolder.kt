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
import com.antelo97.harrypotterapp.databinding.ItemCharacterBinding
import com.antelo97.harrypotterapp.ui.viewmodel.MainViewModel
import com.squareup.picasso.Picasso
import kotlinx.coroutines.launch

class CharactersViewHolder(
    private val mainViewModel: MainViewModel,
    private val lifecycleOwner: LifecycleOwner,
    val view: View,
) : RecyclerView.ViewHolder(view) {

    private val itemCharacterBinding = ItemCharacterBinding.bind(view)

    @SuppressLint("SetTextI18n")
    fun render(character: com.antelo97.harrypotterapp.domain.model.Character, position: Int) {
        itemCharacterBinding.tvCharacterName.text = character.name
        itemCharacterBinding.tvCharacterDetails.text =
            "\n   \u2022 Species: " + character.species + "\n" +
                    "   \u2022 Gender: " + character.gender + "\n" +
                    "   \u2022 House: " + character.house + "\n" +
                    "   \u2022 Year of birth: " + character.yearOfBirth + "\n" +
                    "   \u2022 Is wizard?: " + character.isWizard + "\n" +
                    "   \u2022 Ancestry: " + character.ancestry + "\n" +
                    "   \u2022 Patronus: " + character.gender + "\n" +
                    "   \u2022 Actor: " + character.actor + "\n" +
                    "   \u2022 Wand:\n" +
                    "       - Wood: " + character.wand.wood + "\n" +
                    "       - Core: " + character.wand.core + "\n" +
                    "       - Length: " + character.wand.length + "\n\n\n\n\n"
        Picasso.get().load(character.imageUrl).into(itemCharacterBinding.ivCharacter)

        itemCharacterBinding.ivCharacterDetail.setOnClickListener {
            val blackColor = ContextCompat.getColor(
                view.context,
                R.color.hp_black
            )
            val whiteColor = ContextCompat.getColor(
                view.context,
                R.color.hp_white
            )
            val isVisible = itemCharacterBinding.tvCharacterDetails.isVisible
            itemCharacterBinding.tvCharacterDetails.isVisible = !isVisible
            itemCharacterBinding.ivCharacterDetail.setImageResource(
                if (isVisible) R.drawable.ic_more_info else R.drawable.ic_less_info2
            )
            itemCharacterBinding.ivCharacterDetail.setColorFilter(
                if (isVisible) blackColor else whiteColor
            )
            itemCharacterBinding.llInfoCharacter.setBackgroundColor(
                ContextCompat.getColor(
                    view.context,
                    if (isVisible) R.color.hp_light_brown_opacity_80 else R.color.hp_black_opacity_60
                )
            )
            itemCharacterBinding.tvCharacterName.setTextColor(
                if (isVisible) blackColor else whiteColor
            )
            itemCharacterBinding.tvCharacterDetails.setTextColor(
                if (isVisible) blackColor else whiteColor
            )
            itemCharacterBinding.ivCharacterFavorite.isEnabled = isVisible
        }

        itemCharacterBinding.ivCharacterFavorite.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.updateFavoriteCharacter(character, position)
                mainViewModel.updateButtonStatesCharacters()
            }
        }

        initObservers(character)
    }

    fun initObservers(character: com.antelo97.harrypotterapp.domain.model.Character) {
        mainViewModel.foundCharacters.observe(lifecycleOwner) {
            val color = if (character.isFavorite) R.color.hp_gold else R.color.hp_white
            DrawableCompat.setTint(
                itemCharacterBinding.ivCharacterFavorite.drawable,
                ContextCompat.getColor(view.context, color)
            )
        }
    }
}