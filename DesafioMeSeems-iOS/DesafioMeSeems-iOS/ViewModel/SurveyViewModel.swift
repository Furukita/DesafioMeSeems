//
//  SurveyViewModel.swift
//  DesafioMeSeems-iOS
//
//  Created by Allan Furukita on 16/06/25.
//

import Foundation

class SurveyViewModel {
    private let repository = SurveyRepository()
    private(set) var surveys: [Survey] = []

    func loadSurveys() {
        surveys = repository.fetchSurveys()
    }

    func survey(at index: Int) -> Survey {
        return surveys[index]
    }

    var count: Int {
        return surveys.count
    }
}
