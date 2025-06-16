package com.example.desafiomeseems

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.desafiomeseems.data.SurveyRepository
import com.example.desafiomeseems.ui.adapter.SurveyItemAdapter
import com.example.desafiomeseems.viewmodel.SurveyViewModel

class MainActivity : AppCompatActivity() {

    private lateinit var viewModel: SurveyViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val repository = SurveyRepository(applicationContext)
        viewModel = SurveyViewModel(repository)

        setContentView(R.layout.activity_main)
        val recyclerView = findViewById<RecyclerView>(R.id.rvSurveys)
        recyclerView.layoutManager = LinearLayoutManager(this)
        viewModel.surveyList.observe(this) { surveys ->
            recyclerView.adapter = SurveyItemAdapter(surveys)
        }
    }
}
