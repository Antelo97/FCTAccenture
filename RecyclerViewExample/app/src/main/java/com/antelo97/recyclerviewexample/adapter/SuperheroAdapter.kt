package com.antelo97.recyclerviewexample.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.antelo97.recyclerviewexample.R
import com.antelo97.recyclerviewexample.Superhero

class SuperheroAdapter(
    private val superheroList: List<Superhero>,
    private val onClickListener: (Superhero) -> Unit
) :
    RecyclerView.Adapter<SuperheroViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): SuperheroViewHolder {
        val layoutInflater: LayoutInflater = LayoutInflater.from(parent.context)
        return SuperheroViewHolder(layoutInflater.inflate(R.layout.item_superhero, parent, false))
    }

    override fun getItemCount(): Int = superheroList.size


    override fun onBindViewHolder(holder: SuperheroViewHolder, position: Int) {
        val item = superheroList[position]
        holder.render(item, onClickListener)
    }
}