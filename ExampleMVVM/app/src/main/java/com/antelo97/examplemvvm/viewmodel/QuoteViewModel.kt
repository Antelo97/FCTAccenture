package com.antelo97.examplemvvm.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.antelo97.examplemvvm.model.QuoteModel
import com.antelo97.examplemvvm.model.QuoteProvider

class QuoteViewModel : ViewModel() {
    val quoteModel: MutableLiveData<QuoteModel> = MutableLiveData<QuoteModel>()

    fun randomQuote() {
        val currentQuote: QuoteModel = QuoteProvider.random()
        quoteModel.postValue(currentQuote)
    }
}