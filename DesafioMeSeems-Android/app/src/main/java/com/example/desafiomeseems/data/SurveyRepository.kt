package com.example.desafiomeseems.data

import android.content.Context
import com.example.desafiomeseems.R
import com.example.desafiomeseems.model.Survey
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken

class SurveyRepository(private val context: Context) {

    private val allSurveys: List<Survey> by lazy {
        val json = fetchSurveys()
        val type = object : TypeToken<List<Survey>>() {}.type
        Gson().fromJson(json, type)
    }

    fun getSurveys(page: Int, pageSize: Int): List<Survey> {
        val fromIndex = page * pageSize
        val toIndex = (fromIndex + pageSize).coerceAtMost(allSurveys.size)

        return if (fromIndex < toIndex) {
            allSurveys.subList(fromIndex, toIndex)
        } else {
            emptyList()
        }
    }

    private fun fetchSurveys(): String {
        val inputStream = context.resources.openRawResource(R.raw.surveys)
        return inputStream.bufferedReader().use { it.readText() }
    }
}
