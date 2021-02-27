//
//  CountryDetailsViewController.swift
//  MBCountries
//
//  Created by Parimal Modi on 27/02/21.
//

import UIKit

final class CountryDetailsViewController: BaseViewController {

    @IBOutlet private weak var countryDetailsTableView: UITableView!
    @IBOutlet private weak var emptyStateLabel: UILabel!
    private let viewModel = CountryDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.screenTitle
        loadData()
    }

    private func loadData() {
        emptyStateLabel.isHidden = true
        countryDetailsTableView.isHidden = true
        showLoadingView()
        viewModel.loadData { [weak self] result in
            if let msg = result.errorMsg {
                self?.handleError(msg: msg)
            } else {
                self?.handleSuccess()
            }
            self?.hideLoadingView()
        }
    }
    
    private func handleSuccess() {
        DispatchQueue.main.async { [weak self] in
            if self?.viewModel.dataArray.isEmpty == true {
                self?.showEmptyState()
            } else {
                self?.countryDetailsTableView.isHidden = false
                self?.countryDetailsTableView.reloadData()
            }
        }
    }
    
    private func handleError(msg: String) {
        ScreenDisplayUtilities.displayRetryAlert(msg: msg) { [weak self] in
            self?.loadData()
        } cancelAction: { [weak self] in
            self?.hideLoadingView()
            self?.showEmptyState()
        }
    }
    
    private func showEmptyState() {
        Thread.executeOnMainThread { [weak self] in
            self?.emptyStateLabel.isHidden = false
        }
    }
    
    func setCountryCellViewModel(_ cellViewModel: CountryCellViewModel) {
        viewModel.setCountryCellViewModel(cellViewModel)
    }
}

//MARK: UITableViewDataSource
extension CountryDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
        cell.textLabel?.text = viewModel.dataArray[indexPath.row].name
        return cell
    }
}
