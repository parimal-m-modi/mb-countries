//
//  ICountryDetailsDataDao.swift
//  MBCountries
//
//  Created by Parimal Modi on 27/02/21.
//

protocol ICountryDetailsDataDao {
    func loadData(id: Int, completion: @escaping (Result<[Province], Error>) -> Void)
}
