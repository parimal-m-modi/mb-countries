//
//  CountriesViewModel.swift
//  MBCountries
//
//  Created by Parimal Modi on 27/02/21.
//

struct Response {
    let dataArray: [CountryCellViewModel]?
    let errorMsg: String?
}

final class CountriesViewModel {
    var dataArray: [CountryCellViewModel] = []
    let dataDao = CountriesDataDao()
    
    //Prefer doing reactive with MVVM but figured can work with closures as well to save some time
    func loadData(completion: @escaping ((Response) -> Void)) {
        dataDao.loadData { [weak self] result in
            switch result {
            case .failure:
                completion(Response(dataArray: nil, errorMsg: "Unable to fetch data from server."))
                
            case let .success(countriesArray):
                self?.dataArray = countriesArray.map { CountryCellViewModel(country: $0) }
                completion(Response(dataArray: self?.dataArray, errorMsg: nil))
            }
        }
    }
}
