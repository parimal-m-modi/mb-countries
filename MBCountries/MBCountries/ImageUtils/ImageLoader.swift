//
//  ImageLoader.swift
//  MBCountries
//
//  Created by Parimal Modi on 27/02/21.
//

import Foundation
import UIKit

final class ImageLoader {
    var apiRequestManager: ApiRequestManager?
    
    func loadImage(country: Country, size: Int, closure: @escaping ((UIImage) -> Void)) {
        if let image = ImageCacheManager.get(imageUrl: country.code) {
            closure(image)
        } else {
            apiRequestManager = ApiRequestManager()
            apiRequestManager!.downloadImage(country: country, size: size) { result in
                switch result {
                case let .success(data):
                    if let uiImage = UIImage(data: data) {
                        closure(uiImage)
                        ImageCacheManager.add(imageUrl: country.code, image: uiImage)
                        return
                    }
                default:
                    print("default: getImage()")
                }
                print("ImageLoader :: Used placeholder image for code = \(country.code)")
                closure(UIImage(named: "country_placeholder")!)
            }
        }
    }
    
    func cancelRequest() {
        apiRequestManager?.cancelRequest()
    }
    
    deinit {
        print("Deinit :: ImageLoader")
    }
}
