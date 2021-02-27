//
//  CountryDetailsNetworkDao.swift
//  MBCountries
//
//  Created by Parimal Modi on 27/02/21.
//

final class CountryDetailsNetworkDao: ICountryDetailsDataDao {
    
    private let requestManager = ApiRequestManager()
    
    func loadData(id: Int, completion: @escaping (Result<[Province], Error>) -> Void) {
        requestManager.loadCountryDetailsData(id: id, completion: completion)
    }
}
