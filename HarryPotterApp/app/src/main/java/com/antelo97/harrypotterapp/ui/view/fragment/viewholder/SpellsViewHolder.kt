package com.antelo97.harrypotterapp.ui.view.fragment.viewholder

import android.view.View
import androidx.recyclerview.widget.RecyclerView
import com.antelo97.harrypotterapp.domain.model.Spell
import com.antelo97.harrypotterapp.ui.viewmodel.MainViewModel

class SpellsViewHolder(
    val view: View,
    private val mainViewModel: MainViewModel,
) : RecyclerView.ViewHolder(view) {

    fun render(spell: Spell, position: Int) {

    }
}