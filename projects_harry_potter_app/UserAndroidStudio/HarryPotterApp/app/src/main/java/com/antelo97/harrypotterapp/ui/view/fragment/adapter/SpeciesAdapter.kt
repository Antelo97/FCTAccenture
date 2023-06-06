package com.antelo97.harrypotterapp.ui.view.fragment.adapter

import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.lifecycle.LifecycleOwner
import androidx.recyclerview.widget.RecyclerView
import com.antelo97.harrypotterapp.R
import com.antelo97.harrypotterapp.domain.model.Species
import com.antelo97.harrypotterapp.ui.view.fragment.viewholder.SpeciesViewHolder
import com.antelo97.harrypotterapp.ui.viewmodel.MainViewModel

class SpeciesAdapter(
    private val mainViewModel: MainViewModel,
    private val lifecycleOwner: LifecycleOwner,
    var foundSpecies: List<Species> = emptyList()
) : RecyclerView.Adapter<SpeciesViewHolder>() {

    @SuppressLint("NotifyDataSetChanged")
    fun updateList(foundSpecies: List<Species>) {
        this.foundSpecies = foundSpecies
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): SpeciesViewHolder {
        val layoutInflater = LayoutInflater.from(parent.context)
        val view = layoutInflater.inflate(R.layout.item_species, parent, false)
        return SpeciesViewHolder(mainViewModel, lifecycleOwner, view)
    }

    override fun getItemCount() = foundSpecies.size

    override fun onBindViewHolder(viewHolder: SpeciesViewHolder, position: Int) {
        viewHolder.render(foundSpecies[position], position)
    }
}