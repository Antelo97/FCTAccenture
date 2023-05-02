package com.antelo97.harrypotterapp.ui.view.fragment.adapter

import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.LifecycleOwner
import androidx.recyclerview.widget.RecyclerView
import com.antelo97.harrypotterapp.R
import com.antelo97.harrypotterapp.domain.model.Spell
import com.antelo97.harrypotterapp.ui.view.fragment.viewholder.SpellsViewHolder
import com.antelo97.harrypotterapp.ui.viewmodel.MainViewModel

class SpellsAdapter(
    private val mainViewModel: MainViewModel,
    private val lifecycleOwner: LifecycleOwner,
    var foundSpells: List<Spell> = emptyList()
) : RecyclerView.Adapter<SpellsViewHolder>() {

    // Funcionamiento similar al de un set de Java
    @SuppressLint("NotifyDataSetChanged")
    fun updateList(foundSpells: List<Spell>) {
        this.foundSpells = foundSpells
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): SpellsViewHolder {
        val layoutInflater: LayoutInflater = LayoutInflater.from(parent.context)
        val view: View = layoutInflater.inflate(R.layout.item_spell, parent, false)
        return SpellsViewHolder(mainViewModel, lifecycleOwner, view)
    }

    override fun getItemCount() = foundSpells.size

    override fun onBindViewHolder(viewHolder: SpellsViewHolder, position: Int) {
        viewHolder.render(foundSpells[position], position)
    }
}