package com.antelo97.recyclerviewexample.adapter

import android.view.View
import android.widget.Toast
import androidx.recyclerview.widget.RecyclerView
import com.antelo97.recyclerviewexample.Superhero
import com.antelo97.recyclerviewexample.databinding.ItemSuperheroBinding
import com.squareup.picasso.Picasso

class SuperheroViewHolder(view: View) : RecyclerView.ViewHolder(view) {

    private val binding = ItemSuperheroBinding.bind(view)

    fun render(superheroModel: Superhero, onClickListener: (Superhero) -> Unit) {
        binding.tvSuperheroName.text = superheroModel.superhero
        binding.tvPublisher.text = superheroModel.publisher
        binding.tvRealName.text = superheroModel.realName
        Picasso.get().load(superheroModel.image).into(binding.ivSuperhero)

        itemView.setOnClickListener { onClickListener(superheroModel) }

        /*binding.ivSuperhero.setOnClickListener {
            Toast.makeText(
                binding.ivSuperhero.context,
                superheroModel.realName,
                Toast.LENGTH_SHORT
            ).show()
        }

        itemView.setOnClickListener {
            Toast.makeText(
                binding.ivSuperhero.context,
                superheroModel.superhero,
                Toast.LENGTH_SHORT
            ).show()
        }*/
    }
}