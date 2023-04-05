package com.antelo97.androidmaster

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import com.antelo97.androidmaster.firstapp.FirstAppActivity
import com.antelo97.androidmaster.imccalculator.ImcCalculatorActivity
import com.antelo97.androidmaster.superheroapp.SuperHeroListActivity
import com.antelo97.androidmaster.todoapp.ToDoActivity

class MenuActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_menu)

        val btnSaludApp = findViewById<Button>(R.id.btnSaludApp)
        btnSaludApp.setOnClickListener { navigateToSaludaApp() }
        val btnIMCApp = findViewById<Button>(R.id.btnIMCApp)
        btnIMCApp.setOnClickListener { navigateToIMCApp() }
        val btnToDo = findViewById<Button>(R.id.btnToDo)
        btnToDo.setOnClickListener { navigateToToDoApp() }
        val btnSuperHeroApp = findViewById<Button>(R.id.btnSuperHeroApp)
        btnSuperHeroApp.setOnClickListener { navigateToSuperHeroApp() }
    }

    private fun navigateToSuperHeroApp() {
        val intent = Intent(this, SuperHeroListActivity::class.java)
        startActivity(intent)
    }

    private fun navigateToToDoApp() {
        val intent = Intent(this, ToDoActivity::class.java)
        startActivity(intent)
    }

    private fun navigateToIMCApp() {
        val intent = Intent(this, ImcCalculatorActivity::class.java)
        startActivity(intent)
    }

    private fun navigateToSaludaApp() {
        val intent = Intent(this, FirstAppActivity::class.java)
        startActivity(intent)
    }
}