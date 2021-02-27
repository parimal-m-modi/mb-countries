//
//  ViewController.swift
//  MBCountries
//
//  Created by Parimal Modi on 24/02/21.
//

import UIKit

final class CountriesViewController: BaseViewController {

    @IBOutlet private weak var countriesCollectionView: UICollectionView!
    @IBOutlet private weak var emptyStateLabel: UILabel!
    
    private let viewModel = CountriesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.screenTitle
        showLoadingView()
        loadData()
        configureRefreshControl()
    }
    
    private func configureRefreshControl () {
        countriesCollectionView.refreshControl = UIRefreshControl()
        countriesCollectionView.refreshControl?.addTarget(self,
                                                          action: #selector(loadData),
                                                          for: .valueChanged)
    }
    
    @objc
    private func loadData() {
        emptyStateLabel.isHidden = true
        viewModel.loadData { [weak self] response in
            self?.endPullToRefresh()
            self?.hideLoadingView()
            if let msg = response.errorMsg {
                self?.handleFailure(msg: msg)
            } else {
                self?.handleSuccess()
            }
        }
    }
    
    private func handleSuccess() {
        DispatchQueue.main.async { [weak self] in
            self?.countriesCollectionView.isHidden = false
            self?.countriesCollectionView?.reloadData()
        }
    }
    
    private func handleFailure(msg: String) {
        ScreenDisplayUtilities.displayRetryAlert(msg: msg) { [weak self] in
            self?.showLoadingView()
            self?.loadData()
        } cancelAction: { [weak self] in
            self?.hideLoadingView()
            self?.showEmptyState()
        }
    }
    
    private func endPullToRefresh() {
        Thread.executeOnMainThread { [weak self] in
            self?.countriesCollectionView.refreshControl?.endRefreshing()
        }
    }
    
    private func showEmptyState() {
        Thread.executeOnMainThread { [weak self] in
            self?.emptyStateLabel.isHidden = false
        }
    }
}

//MARK: UICollectionViewDataSource
extension CountriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountryCollectionViewCell",
                                                      for: indexPath) as! CountryCollectionViewCell
        cell.configureCell(viewModel: viewModel.dataArray[indexPath.row])
        return cell
    }
}

//MARK: UICollectionViewDelegate
extension CountriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ScreenDisplayUtilities.displayCountryDetailsScreen(cellViewModel: viewModel.dataArray[indexPath.row])
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension CountriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
        let cellSpacing = isIpad ? 50 : 20
        let width = CGFloat((Int(collectionView.bounds.size.width) - cellSpacing) / (isIpad ? 6 : 3))
        return CGSize(width: width, height: width + 20)
    }
}
