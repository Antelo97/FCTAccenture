package com.antelo97.harrypotterapp.ui.view.fragment.adapter

import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.lifecycle.LifecycleOwner
import androidx.recyclerview.widget.RecyclerView
import com.antelo97.harrypotterapp.R
import com.antelo97.harrypotterapp.domain.model.Character
import com.antelo97.harrypotterapp.ui.view.fragment.viewholder.CharactersViewHolder
import com.antelo97.harrypotterapp.ui.viewmodel.MainViewModel

class CharactersAdapter(
    private val mainViewModel: MainViewModel,
    private val lifecycleOwner: LifecycleOwner,
    var foundCharacters: List<Character> = emptyList()
) : RecyclerView.Adapter<CharactersViewHolder>() {

    @SuppressLint("NotifyDataSetChanged")
    fun updateList(foundCharacters: List<Character>) {
        this.foundCharacters = foundCharacters
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CharactersViewHolder {
        val layoutInflater = LayoutInflater.from(parent.context)
        val view = layoutInflater.inflate(R.layout.item_character, parent, false)
        return CharactersViewHolder(mainViewModel, lifecycleOwner, view)
    }

    override fun getItemCount() = foundCharacters.size

    override fun onBindViewHolder(holder: CharactersViewHolder, position: Int) {
        holder.render(foundCharacters[position], position)
    }
}