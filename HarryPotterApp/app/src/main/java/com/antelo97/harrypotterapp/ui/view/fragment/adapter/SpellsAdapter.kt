package com.antelo97.harrypotterapp.ui.view.fragment.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.antelo97.harrypotterapp.R
import com.antelo97.harrypotterapp.domain.model.Spell
import com.antelo97.harrypotterapp.ui.view.fragment.viewholder.SpellsViewHolder
import com.antelo97.harrypotterapp.ui.viewmodel.MainViewModel

class SpellsAdapter(
    private val mainViewModel: MainViewModel,
    var foundSpells: List<Spell> = emptyList()
) : RecyclerView.Adapter<SpellsViewHolder>() {

    fun updateList(foundSpells: List<Spell>) {
        this.foundSpells = foundSpells
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): SpellsViewHolder {
        val layoutInflater: LayoutInflater = LayoutInflater.from(parent.context)
        val view: View = layoutInflater.inflate(R.layout.item_spell, parent, false)
        return SpellsViewHolder(view, mainViewModel)
    }

    override fun getItemCount() = foundSpells.size

    override fun onBindViewHolder(viewHolder: SpellsViewHolder, position: Int) {
        viewHolder.render(foundSpells[position], position)
    }
}