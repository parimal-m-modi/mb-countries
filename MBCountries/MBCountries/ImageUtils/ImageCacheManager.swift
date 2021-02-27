//
//  ImageCacheManager.swift
//  MBCountries
//
//  Created by Parimal Modi on 27/02/21.
//

import Foundation
import UIKit

final class ImageCacheManager {
    let cache = NSCache<NSString, UIImage>()
    private static var sharedInstance = ImageCacheManager()
    
    private init() {
        cache.countLimit = 500
        cache.totalCostLimit = 25 * 1024 * 1024
    }
    
    static func add(imageUrl: String, image: UIImage) {
        sharedInstance.cache.setObject(image, forKey: imageUrl as NSString)
    }
    
    static func get(imageUrl: String) -> UIImage? {
        sharedInstance.cache.object(forKey: imageUrl as NSString)
    }
}
