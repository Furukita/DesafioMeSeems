package com.example.desafiomeseems

import android.os.Bundle
import android.view.View
import android.widget.ProgressBar
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.desafiomeseems.data.SurveyRepository
import com.example.desafiomeseems.ui.adapter.SurveyItemAdapter
import com.example.desafiomeseems.viewmodel.SurveyViewModel

class MainActivity : AppCompatActivity() {

    private lateinit var viewModel: SurveyViewModel
    private lateinit var adapter: SurveyItemAdapter
    private lateinit var recyclerView: RecyclerView
    private lateinit var progressBar: ProgressBar

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val repository = SurveyRepository(applicationContext)
        viewModel = SurveyViewModel(repository)

        setContentView(R.layout.activity_main)

        recyclerView = findViewById(R.id.rvSurveys)
        progressBar = findViewById(R.id.progressBar)

        recyclerView.layoutManager = LinearLayoutManager(this)
        adapter = SurveyItemAdapter(mutableListOf())
        recyclerView.adapter = adapter

        viewModel.surveyList.observe(this) { surveys ->
            adapter.updateData(surveys)
        }

        viewModel.isLoading.observe(this) { isLoading ->
            progressBar.visibility = if (isLoading) View.VISIBLE else View.GONE
        }

        recyclerView.addOnScrollListener(object : RecyclerView.OnScrollListener() {
            override fun onScrolled(rv: RecyclerView, dx: Int, dy: Int) {
                super.onScrolled(rv, dx, dy)
                val layoutManager = rv.layoutManager as LinearLayoutManager
                val totalItemCount = layoutManager.itemCount
                val lastVisible = layoutManager.findLastVisibleItemPosition()

                if (lastVisible + 2 >= totalItemCount) {
                    viewModel.loadMoreSurveys()
                }
            }
        })
    }
}
