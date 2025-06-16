package com.example.desafiomeseems.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.desafiomeseems.data.SurveyRepository
import com.example.desafiomeseems.model.Survey

class SurveyViewModel(private val repository: SurveyRepository) : ViewModel() {
    private val _surveyList = MutableLiveData<List<Survey>>()
    val surveyList: LiveData<List<Survey>> = _surveyList

    init {
        loadSurveys()
    }

    private fun loadSurveys() {
        val surveys = repository.getSurveys()
        _surveyList.value = surveys
    }
}
