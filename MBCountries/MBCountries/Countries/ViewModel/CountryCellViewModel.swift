//
//  CountryCellViewModel.swift
//  MBCountries
//
//  Created by Parimal Modi on 27/02/21.
//

final class CountryCellViewModel {
    private let country: Country
    
    init(country: Country) {
        self.country = country
    }
    
    deinit {
        print("deinit CountryCellViewModel")
    }
}
