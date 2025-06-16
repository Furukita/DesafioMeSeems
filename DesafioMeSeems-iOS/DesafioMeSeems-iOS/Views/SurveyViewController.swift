//
//  SurveyViewController.swift
//  DesafioMeSeems-iOS
//
//  Created by Allan Furukita on 16/06/25.
//

import UIKit

class SurveyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    private let viewModel = SurveyViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Pesquisas"
        view.backgroundColor = .systemBackground

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100

        viewModel.loadSurveys()
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: SurveyCell.identifier, for: indexPath) as? SurveyCell else {
            return UITableViewCell()
        }

        let survey = viewModel.survey(at: indexPath.row)
        cell.configure(with: survey)
        cell.selectionStyle = .none


        cell.onAnswerTapped = { [weak self] in
            self?.showPopup(for: survey)
        }

        return cell
    }

    private func showPopup(for survey: Survey) {
        let alert = UIAlertController(title: "Início da pesquisa", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
