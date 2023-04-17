package com.antelo97.harrypotterapp.ui.view

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.antelo97.harrypotterapp.R
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }
}