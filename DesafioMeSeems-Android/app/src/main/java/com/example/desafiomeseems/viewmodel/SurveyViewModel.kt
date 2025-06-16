package com.example.desafiomeseems.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.desafiomeseems.data.SurveyRepository
import com.example.desafiomeseems.model.Survey

class SurveyViewModel(private val repository: SurveyRepository) : ViewModel() {

    private val _surveyList = MutableLiveData<List<Survey>>(emptyList())
    val surveyList: LiveData<List<Survey>> = _surveyList

    private val _isLoading = MutableLiveData<Boolean>(false)
    val isLoading: LiveData<Boolean> = _isLoading

    private var currentPage = 0
    private val pageSize = 5
    private var hasMoreData = true

    init {
        loadMoreSurveys()
    }

    fun loadMoreSurveys() {
        if (_isLoading.value == true || !hasMoreData) return

        _isLoading.postValue(true)

        Thread {
            Thread.sleep(1000)

            val newSurveys = repository.getSurveys(currentPage, pageSize)

            if (newSurveys.isEmpty()) {
                hasMoreData = false
            } else {
                val updatedList = _surveyList.value.orEmpty() + newSurveys
                _surveyList.postValue(updatedList)
                currentPage++
            }

            _isLoading.postValue(false)
        }.start()
    }
}
