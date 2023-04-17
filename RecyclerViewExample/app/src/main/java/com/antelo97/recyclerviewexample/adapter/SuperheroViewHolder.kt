package com.antelo97.recyclerviewexample.adapter

import android.view.View
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.antelo97.recyclerviewexample.R
import com.antelo97.recyclerviewexample.Superhero
import com.squareup.picasso.Picasso

class SuperheroViewHolder(view: View) : RecyclerView.ViewHolder(view) {

    val tvSuperheroName = view.findViewById<TextView>(R.id.tvSuperheroName)
    val tvPublisher = view.findViewById<TextView>(R.id.tvPublisher)
    val tvRealName = view.findViewById<TextView>(R.id.tvRealName)
    val ivSuperhero = view.findViewById<ImageView>(R.id.ivSuperhero)

    fun render(superheroModel: Superhero) {
        tvSuperheroName.text = superheroModel.superhero
        tvPublisher.text = superheroModel.publisher
        tvRealName.text = superheroModel.realName
        Picasso.get().load(superheroModel.image).into(ivSuperhero)
    }
}