package com.example.desafiomeseems.ui.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.recyclerview.widget.RecyclerView
import com.example.desafiomeseems.R
import com.example.desafiomeseems.model.Survey

class SurveyItemAdapter(
    private val surveyList: List<Survey>
) : RecyclerView.Adapter<SurveyItemAdapter.SurveyViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): SurveyViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.item_survey, parent, false)
        return SurveyViewHolder(view)
    }

    override fun onBindViewHolder(holder: SurveyViewHolder, position: Int) {
        val survey = surveyList[position]
        holder.bind(survey)
    }

    override fun getItemCount(): Int = surveyList.size

    inner class SurveyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        private val tvTitle: TextView = itemView.findViewById(R.id.tvTitle)
        private val tvTime: TextView = itemView.findViewById(R.id.tvTime)
        private val tvReward: TextView = itemView.findViewById(R.id.tvReward)
        private val btnRespond: Button = itemView.findViewById(R.id.btAnswer)

        fun bind(survey: Survey) {
            tvTitle.text = survey.title
            tvTime.text = "Tempo estimado: ${survey.estimatedTime}"
            tvReward.text = "${survey.reward}"

            btnRespond.setOnClickListener {
                AlertDialog.Builder(itemView.context)
                    .setTitle("Início da pesquisa")
                    .setPositiveButton("Fechar") { dialog, _ -> dialog.dismiss() }
                    .show()
            }
        }
    }
}
