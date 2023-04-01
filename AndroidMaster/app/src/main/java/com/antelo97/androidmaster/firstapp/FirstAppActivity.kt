package com.antelo97.androidmaster.firstapp

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import androidx.appcompat.widget.AppCompatButton
import androidx.appcompat.widget.AppCompatEditText
import androidx.constraintlayout.widget.ConstraintLayout
import com.antelo97.androidmaster.R
import com.antelo97.androidmaster.layouts.ConstraintLayoutActivity
import com.antelo97.androidmaster.layouts.ConstraintLayoutActivityV2
import com.antelo97.androidmaster.layouts.FrameLayoutActivity
import com.antelo97.androidmaster.layouts.LinearLayoutActivity

class FirstAppActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_first_app)

        val btnStart = findViewById<AppCompatButton>(R.id.btnStart)
        val etName = findViewById<AppCompatEditText>(R.id.etName)

        btnStart.setOnClickListener {
            val name = etName.text.toString()

            if (name.isNotEmpty()) {
                val intent = Intent(this, ConstraintLayoutActivityV2::class.java)
                intent.putExtra("EXTRA NAME", name)
                startActivity(intent)
            }
        }
        // Al arrancar la pantalla
    }
}
