package com.antelo97.harrypotterapp.ui.view.fragment

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.antelo97.harrypotterapp.R
import com.antelo97.harrypotterapp.databinding.FragmentSpeciesBinding

class SpeciesFragment : Fragment() {
    private lateinit var bindingSpellsSpecies: FragmentSpeciesBinding


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_species, container, false)
    }

    companion object {
        @JvmStatic
        fun newInstance() = SpeciesFragment()
    }
}