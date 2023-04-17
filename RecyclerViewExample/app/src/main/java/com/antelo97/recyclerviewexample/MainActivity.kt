package com.antelo97.recyclerviewexample

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.antelo97.recyclerviewexample.adapter.SuperheroAdapter

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        initRecyclerView()
    }

    private fun initRecyclerView() {
        val rvSuperhero = findViewById<RecyclerView>(R.id.rvSuperhero)
        rvSuperhero.layoutManager = LinearLayoutManager(this)
        rvSuperhero.adapter = SuperheroAdapter(SuperheroProvider.superheroList)
    }
}