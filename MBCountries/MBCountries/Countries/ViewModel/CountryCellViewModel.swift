//
//  CountryCellViewModel.swift
//  MBCountries
//
//  Created by Parimal Modi on 27/02/21.
//

import UIKit

final class CountryCellViewModel {
    private let country: Country
    private let imageLoader = ImageLoader()
    
    init(country: Country) {
        self.country = country
    }
    
    var name: String {
        country.name
    }
    
    var id: Int {
        country.id
    }
    
    func getImage(size: Int, closure: @escaping ((UIImage) -> Void)) {
        imageLoader.loadImage(country: country, size: size, closure: closure)
    }
}
