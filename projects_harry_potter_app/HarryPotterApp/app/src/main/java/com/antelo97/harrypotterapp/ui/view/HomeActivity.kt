package com.antelo97.harrypotterapp.ui.view

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.antelo97.harrypotterapp.R
import com.antelo97.harrypotterapp.databinding.ActivityAuthBinding
import com.antelo97.harrypotterapp.databinding.ActivityHomeBinding
import com.google.firebase.auth.FirebaseAuth

enum class ProviderType {
    BASIC
}

class HomeActivity : AppCompatActivity() {
    private lateinit var homeBinding: ActivityHomeBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        homeBinding = ActivityHomeBinding.inflate(layoutInflater)
        setContentView(homeBinding.root)

        val bundle: Bundle? = intent.extras
        val email = bundle?.getString("email")
        val provider = bundle?.getString("provider")
        initUI(email ?: "", provider ?: "")
    }

    private fun initUI(email: String, provider: String) {
        homeBinding.tvEmail.text = email
        homeBinding.tvProvider.text = provider

        homeBinding.btnLogOut.setOnClickListener {
            FirebaseAuth.getInstance().signOut()
            onBackPressed()
        }
    }
}