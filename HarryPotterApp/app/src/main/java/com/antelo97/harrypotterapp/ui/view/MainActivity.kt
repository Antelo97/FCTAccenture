package com.antelo97.harrypotterapp.ui.view

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.activity.viewModels
import androidx.lifecycle.Observer
import com.antelo97.harrypotterapp.databinding.ActivityMainBinding
import com.antelo97.harrypotterapp.ui.viewmodel.MainViewModel
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class MainActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding
    private val bookViewModel: MainViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        bookViewModel.onCreate()

        bookViewModel.book.observe(this, Observer { book ->
            binding.tvTitle.text = book.title
            binding.tvAuthor.text = book.author
            binding.tvDataRelease.text = book.releaseDate
        })
    }
}