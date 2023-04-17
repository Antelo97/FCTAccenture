package com.antelo97.recyclerviewexample

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.antelo97.recyclerviewexample.adapter.SuperheroAdapter
import com.antelo97.recyclerviewexample.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        initRecyclerView()
    }

    private fun initRecyclerView() {
        val manager = LinearLayoutManager(this)
        // val manager = GridLayoutManager(this, 2)
        val decoration = DividerItemDecoration(this, manager.orientation)
        binding.rvSuperhero.layoutManager = manager
        binding.rvSuperhero.adapter =
            SuperheroAdapter(
                SuperheroProvider.superheroList
            ) { superhero -> onItemSelected(superhero) }
        binding.rvSuperhero.addItemDecoration(decoration)
    }

    fun onItemSelected(superhero: Superhero) {
        Toast.makeText(this, superhero.superhero, Toast.LENGTH_SHORT).show()
    }
}