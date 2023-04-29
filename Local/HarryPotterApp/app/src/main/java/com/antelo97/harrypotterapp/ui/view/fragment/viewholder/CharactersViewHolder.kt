package com.antelo97.harrypotterapp.ui.view.fragment.viewholder

import android.annotation.SuppressLint
import android.util.Log
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
import java.text.FieldPosition

class CharactersViewHolder(
    private val mainViewModel: MainViewModel,
    private val lifecycleOwner: LifecycleOwner,
    val view: View,
) : RecyclerView.ViewHolder(view) {

    private val binding = ItemCharacterBinding.bind(view)

    @SuppressLint("SetTextI18n")
    fun render(character: com.antelo97.harrypotterapp.domain.model.Character, position: Int) {
        binding.tvCharacterName.text = character.name
        binding.tvCharacterDetails.text = "\u2022 Species: " + character.species + "\n " +
                "\u2022 Gender: " + character.gender + "\n" +
                "\u2022 House: " + character.house + "\n" +
                "\u2022 Year of birth: " + character.yearOfBirth + "\n" +
                "\u2022 Is wizard?: " + character.isWizard + "\n" +
                "\u2022 Ancestry: " + character.ancestry + "\n" +
                "\u2022 Patronus: " + character.gender + "\n" +
                "\u2022 Is Hogwatrs student?: " + character.isHogwartsStudent + "\n" +
                "\u2022 Is Hogwatrs staff?: " + character.isHogwartsStaff + "\n" +
                "\u2022 Actor: " + character.actor + "\n" +
                "\u2022 Is alive?: " + character.isAlive + "\n" +
                "\u2022 Varita:\n" +
                "   Wood: " + character.wand.wood + "\n" +
                "   Core: " + character.wand.core + "\n" +
                "   Length: " + character.wand.length + "\n"
        Picasso.get().load(character.imageUrl).into(binding.ivCharacter)

        binding.ivCharacterDetail.setOnClickListener {
            mainViewModel.modifyInfoDetailCharacter()
        }

        binding.ivCharacterFavorite.setOnClickListener {
            mainViewModel.viewModelScope.launch {
                mainViewModel.updateFavoriteCharacter(character, position)
            }
        }

        initObservers(character)
    }

    fun initObservers(character: com.antelo97.harrypotterapp.domain.model.Character) {
        mainViewModel.foundCharacters.observe(lifecycleOwner) {
            val color = if (character.isFavorite) R.color.hp_gold else R.color.hp_white
            DrawableCompat.setTint(
                binding.ivCharacterFavorite.drawable,
                ContextCompat.getColor(view.context, color)
            )
        }

        mainViewModel.detailsCharacter.observe(lifecycleOwner) { detailsCharacter ->
            binding.tvCharacterDetails.visibility =
                if (detailsCharacter) View.VISIBLE else View.GONE
            binding.ivCharacterDetail.setImageResource(if (detailsCharacter) R.drawable.ic_less_info2 else R.drawable.ic_more_info)
            binding.llInfoCharacter.backgroundTintList = ContextCompat.getColorStateList(
                view.context,
                if (detailsCharacter) R.color.hp_light_brown else R.color.hp_light_brown_opacity_80
            )
        }
    }
}