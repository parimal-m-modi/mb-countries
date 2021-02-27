//
//  ICountriesDataDao.swift
//  MBCountries
//
//  Created by Parimal Modi on 27/02/21.
//

import Foundation

protocol ICountriesDataDao {
    func loadData(completion: @escaping (Result<[Country], Error>) -> Void)
}
