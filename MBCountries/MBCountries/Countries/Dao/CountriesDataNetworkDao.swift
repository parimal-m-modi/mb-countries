//
//  CountriesDataNetworkDao.swift
//  MBCountries
//
//  Created by Parimal Modi on 27/02/21.
//

final class CountriesDataNetworkDao: ICountriesDataDao {
    let requestManager = ApiRequestManager()
    
    func loadData(completion: @escaping (Result<[Country], Error>) -> Void) {
        requestManager.loadData(completion: completion)
    }
    
    deinit {
        print("deinit CountriesDataNetworkDao")
    }
}
