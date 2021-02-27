//
//  CountriesDataDao.swift
//  MBCountries
//
//  Created by Parimal Modi on 27/02/21.
//

final class CountriesDataDao {
    
    static var externalDao: ICountriesDataDao?
    private let dataDao: ICountriesDataDao
    
    init() {
        dataDao = CountriesDataDao.externalDao ?? CountriesDataNetworkDao()
    }
    
    func loadData(completion: @escaping (Result<[Country], Error>) -> Void) {
        dataDao.loadData(completion: completion)
    }
}
