package com.antelo97.examplemvvm.ui.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.antelo97.examplemvvm.data.model.QuoteModel
import com.antelo97.examplemvvm.domain.GetQuotesUseCase
import com.antelo97.examplemvvm.domain.GetRandomQuoteUseCase
import com.antelo97.examplemvvm.domain.model.Quote
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class QuoteViewModel @Inject constructor(
    private val getQuotesUseCase: GetQuotesUseCase,
    private val getRandomQuoteUseCase: GetRandomQuoteUseCase
) : ViewModel() {

    val quoteModel: MutableLiveData<Quote> = MutableLiveData<Quote>()
    val isLoading: MutableLiveData<Boolean> = MutableLiveData<Boolean>()

    /*val getQuotesUseCase = GetQuotesUseCase()
    val getRandomQuoteUseCase = GetRandomQuoteUseCase()*/
    fun onCreate() {
        viewModelScope.launch {
            isLoading.postValue(true)
            val result: List<Quote> = getQuotesUseCase()

            if (!result.isNullOrEmpty()) {
                quoteModel.postValue(result[0])
                isLoading.postValue(false)
            }
        }
    }

    fun randomQuote() {
        /*val currentQuote: QuoteModel = QuoteProvider.random()
        quoteModel.postValue(currentQuote)*/
        isLoading.postValue(true)
        viewModelScope.launch {
            val quote: Quote? = getRandomQuoteUseCase()

            if (quote != null) {
                quoteModel.postValue(quote)
            }
            isLoading.postValue(false)
        }
    }
}