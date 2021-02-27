//
//  ProvinceCellViewModel.swift
//  MBCountries
//
//  Created by Parimal Modi on 27/02/21.
//

final class ProvinceCellViewModel {
    private let province: Province
    
    init(province: Province) {
        self.province = province
    }
    
    var name: String {
        province.name
    }
}
