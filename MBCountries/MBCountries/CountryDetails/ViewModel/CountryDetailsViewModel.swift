//
//  CountryDetailsViewModel.swift
//  MBCountries
//
//  Created by Parimal Modi on 27/02/21.
//

import Foundation

struct CountryDetailsResponse {
    let dataArray: [ProvinceCellViewModel]?
    let errorMsg: String?
}

final class CountryDetailsViewModel {
    private weak var countryCellViewModel: CountryCellViewModel?
    private var dataDao = CountryDetailsDataDao()
    var dataArray: [ProvinceCellViewModel] = []
    
    
    var screenTitle: String? {
        countryCellViewModel?.name
    }
    
    func setCountryCellViewModel(_ viewModel: CountryCellViewModel) {
        self.countryCellViewModel = viewModel
    }
    
    func loadData(completion: @escaping ((CountryDetailsResponse) -> Void)) {
        guard let id = countryCellViewModel?.id else {
            return
        }
        dataDao.loadData(id: id) { [weak self] result in
            switch result {
            case let .failure(error):
                print("error: \(error)")
                completion(CountryDetailsResponse(dataArray: nil, errorMsg: "Unable to fetch data from server."))
                
            case let .success(provinceArray):
                self?.dataArray = provinceArray.map { ProvinceCellViewModel(province: $0) }
                completion(CountryDetailsResponse(dataArray: self?.dataArray, errorMsg: nil))
            }
        }
    }
}
