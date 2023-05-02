package com.antelo97.harrypotterapp.ui.view

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.activity.viewModels
import androidx.appcompat.app.AlertDialog
import com.antelo97.harrypotterapp.databinding.ActivityAuthBinding
import com.antelo97.harrypotterapp.ui.viewmodel.MainViewModel
import com.google.firebase.auth.FirebaseAuth

class AuthActivity : AppCompatActivity() {
    private lateinit var authBinding: ActivityAuthBinding

    private val mainViewModel: MainViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        authBinding = ActivityAuthBinding.inflate(layoutInflater)
        setContentView(authBinding.root)

        initUI()
    }

    private fun initUI() {
        authBinding.btnSignUp.setOnClickListener {
            if (authBinding.etEmail.text.isNotEmpty() && authBinding.etPassword.text.isNotEmpty()) {
                FirebaseAuth.getInstance().createUserWithEmailAndPassword(
                    authBinding.etEmail.text.toString(),
                    authBinding.etPassword.text.toString()
                ).addOnCompleteListener {
                    if (it.isSuccessful) {
                        showRightSignUpDialog(it.result.user?.email!!)
                    } else {
                        showAuthAlert()
                    }
                }
            } else {
                showEmptyFieldsAlert()
            }
        }

        authBinding.btnSignIn.setOnClickListener {
            if (authBinding.etEmail.text.isNotEmpty() && authBinding.etPassword.text.isNotEmpty()) {
                FirebaseAuth.getInstance().signInWithEmailAndPassword(
                    authBinding.etEmail.text.toString(),
                    authBinding.etPassword.text.toString()
                ).addOnCompleteListener {
                    if (it.isSuccessful) {
                        navigateToMain(it.result.user?.email!!)
                    } else {
                        showAuthAlert()
                    }
                }
            } else {
                showEmptyFieldsAlert()
            }
        }
    }

    private fun showAuthAlert() {
        val builder = AlertDialog.Builder(this)
        builder.setTitle("Error")
        builder.setMessage("An error occurred authenticating the user")
        builder.setPositiveButton("Aceptar", null)
        val dialog: AlertDialog = builder.create()
        dialog.setCanceledOnTouchOutside(false)
        dialog.show()
    }

    private fun showEmptyFieldsAlert() {
        val builder: AlertDialog.Builder = AlertDialog.Builder(this)
        builder.setTitle("Error")
        builder.setMessage("The email and password fields cannot be empty")
        builder.setPositiveButton("Accept", null)
        val dialog: AlertDialog = builder.create()
        dialog.setCanceledOnTouchOutside(false)
        dialog.show()
    }

    private fun showRightSignUpDialog(email: String) {
        val builder: AlertDialog.Builder = AlertDialog.Builder(this)
        builder.setTitle("Successful registration")
        builder.setMessage("Congratulations! Your registration has been completed successfully")
        builder.setPositiveButton("Accept") { _, _ ->
            navigateToMain(email)
        }
        val dialog: AlertDialog = builder.create()
        dialog.setCanceledOnTouchOutside(false)
        dialog.show()
    }

    private fun navigateToMain(email: String) {
        val mainIntent: Intent = Intent(this, MainActivity::class.java).apply {
            putExtra("email", email)
        }
        startActivity(mainIntent)
    }
}