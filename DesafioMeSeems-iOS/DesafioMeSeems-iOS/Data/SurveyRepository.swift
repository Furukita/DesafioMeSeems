//
//  SurveyRepository.swift
//  DesafioMeSeems-iOS
//
//  Created by Allan Furukita on 16/06/25.
//

import Foundation

class SurveyRepository {
    func fetchSurveys() -> [Survey] {
        guard let url = Bundle.main.url(forResource: "surveys", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return []
        }

        let surveys = try? JSONDecoder().decode([Survey].self, from: data)
        return surveys ?? []
    }
}
