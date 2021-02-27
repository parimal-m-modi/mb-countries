//
//  CountriesDataNetworkDao.swift
//  MBCountries
//
//  Created by Parimal Modi on 27/02/21.
//

final class CountriesDataNetworkDao: ICountriesDataDao {
    private let requestManager = ApiRequestManager()
    
    func loadData(completion: @escaping (Result<[Country], Error>) -> Void) {
        requestManager.loadCountriesData(completion: completion)
    }
}
