//
//  ViewController.swift
//  MBCountries
//
//  Created by Parimal Modi on 24/02/21.
//

import UIKit

final class CountriesViewController: BaseViewController {

    @IBOutlet private weak var countriesCollectionView: UICollectionView!
    private let viewModel = CountriesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    private func loadData() {
        countriesCollectionView.isHidden = true
        showLoadingView()
        viewModel.loadData { [weak self] response in
            if response.errorMsg != nil {
                print("Display error: \(response.errorMsg!)")
                //Display alert
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.countriesCollectionView.isHidden = false
                    self?.countriesCollectionView?.reloadData()
                }
                self?.hideLoadingView()
            }
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
