//
//  CountryDetailsDataDao.swift
//  MBCountries
//
//  Created by Parimal Modi on 27/02/21.
//

final class CountryDetailsDataDao {
    
    static var externalDao: ICountryDetailsDataDao?
    private let dataDao: ICountryDetailsDataDao
    
    init() {
        dataDao = CountryDetailsDataDao.externalDao ?? CountryDetailsNetworkDao()
    }
    
    func loadData(id: Int, completion: @escaping (Result<[Province], Error>) -> Void) {
        dataDao.loadData(id: id, completion: completion)
    }
}
