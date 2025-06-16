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
    private var isLoadingMore = false

    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Pesquisas"
        view.backgroundColor = .systemBackground

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100

        view.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        spinner.startAnimating()
        viewModel.loadInitialSurveys { [weak self] in
            DispatchQueue.main.async {
                self?.spinner.stopAnimating()
                self?.tableView.reloadData()
            }
        }
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

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height - 100 {
            if !isLoadingMore && viewModel.hasMore {
                loadMoreData()
            }
        }
    }

    private func loadMoreData() {
        isLoadingMore = true
        spinner.startAnimating()

        viewModel.loadMoreSurveys { [weak self] in
            DispatchQueue.main.async {
                self?.spinner.stopAnimating()
                self?.isLoadingMore = false
                self?.tableView.reloadData()
            }
        }
    }

    private func showPopup(for survey: Survey) {
        let alert = UIAlertController(title: "Início da pesquisa", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
