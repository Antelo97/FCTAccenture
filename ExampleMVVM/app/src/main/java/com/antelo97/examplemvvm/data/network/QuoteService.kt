package com.antelo97.examplemvvm.data.network

import com.antelo97.examplemvvm.core.RetrofitHelper
import com.antelo97.examplemvvm.data.model.QuoteModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import retrofit2.Response
import retrofit2.Retrofit
import retrofit2.create
import javax.inject.Inject

class QuoteService @Inject constructor(private val api: QuoteApiClient) {

    // private val retrofit: Retrofit = RetrofitHelper.getRetrofit()

    suspend fun getQuotes(): List<QuoteModel> {
        return withContext(Dispatchers.IO) {
            /*val response: Response<List<QuoteModel>> =
                retrofit.create(QuoteApiClient::class.java).getAllQuotes()*/

            val response: Response<List<QuoteModel>> = api.getAllQuotes()
            response.body().orEmpty()

            // return response.body() ?: emptyList()
        }
    }
}