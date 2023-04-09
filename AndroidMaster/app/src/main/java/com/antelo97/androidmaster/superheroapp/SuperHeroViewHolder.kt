package com.antelo97.androidmaster.superheroapp

import android.view.View
import androidx.recyclerview.widget.RecyclerView
import com.antelo97.androidmaster.databinding.ItemSuperheroBinding

class SuperHeroViewHolder(view: View) : RecyclerView.ViewHolder(view) {

    private val binding = ItemSuperheroBinding.bind(view)

    fun bind(superHeroItemResponse: SuperHeroItemResponse) {
        binding.tvSuperheroName.text = superHeroItemResponse.name
    }
}