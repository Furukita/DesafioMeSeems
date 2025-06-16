//
//  SurveyViewModel.swift
//  DesafioMeSeems-iOS
//
//  Created by Allan Furukita on 16/06/25.
//

import Foundation

class SurveyViewModel {
    private let repository = SurveyRepository()
    private var allSurveys: [Survey] = []
    private(set) var surveys: [Survey] = []

    private let pageSize = 5
    private var currentPage = 0

    var hasMore: Bool {
        return surveys.count < allSurveys.count
    }

    func loadInitialSurveys(completion: @escaping () -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            self.allSurveys = self.repository.fetchSurveys()
            self.surveys = Array(self.allSurveys.prefix(self.pageSize))
            self.currentPage = 1
            DispatchQueue.main.async {
                completion()
            }
        }
    }

    func loadMoreSurveys(completion: @escaping () -> Void) {
        guard hasMore else { return }

        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let start = self.currentPage * self.pageSize
            let end = min(start + self.pageSize, self.allSurveys.count)

            if start < end {
                let nextPage = self.allSurveys[start..<end]
                self.surveys.append(contentsOf: nextPage)
                self.currentPage += 1
            }

            DispatchQueue.main.async {
                completion()
            }
        }
    }

    func survey(at index: Int) -> Survey {
        return surveys[index]
    }

    var count: Int {
        return surveys.count
    }
}
