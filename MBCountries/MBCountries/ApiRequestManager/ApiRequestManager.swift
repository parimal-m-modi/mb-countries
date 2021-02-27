//
//  ApiRequestManager.swift
//  MBCountries
//
//  Created by Parimal Modi on 27/02/21.
//

import Foundation

enum RequestUrl {
    case countriesData
    case imageDownload(country: Country, size: Int)
    
    var url: URL? {
        switch self {
        case .countriesData:
            return URL(string: "https://connect.mindbodyonline.com/rest/worldregions/country")
            
        case let .imageDownload(country, _):
            return URL(string: "https://www.countryflags.io/\(country.code)/shiny/64.png")
        }
    }
}

final class ApiRequestManager {
    private var task: URLSessionTask?
    private var isCancelled = false
    
    func loadData(completion: @escaping (Result<[Country], Error>) -> Void)  {
        let urlSession = URLSession.shared
        guard let url = RequestUrl.countriesData.url else {
            completion(Result.failure(NSError(domain: "Empty Query/Url not found", code: 1, userInfo: nil)))
            return
        }
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.task = urlSession.dataTask(with: url) { [weak self] data, _, error in
                guard self?.isCancelled == false else {
                    print("ApiRequestManager :: requestData :: request cancelled for data url = \(url.absoluteString)")
                    //Since request is cancelled, completion is not required
                    return
                }
                guard let data = data else {
                    completion(Result.failure(NSError(domain: error.debugDescription, code: 2, userInfo: nil)))
                    return
                }
                guard let countriesArray = try? JSONDecoder().decode(Array<Country>.self, from: data) else {
                    completion(.success([]))
                    return
                }
                completion(.success(countriesArray))
            }
            self?.task?.resume()
        }
    }
    
    func downloadImage(country: Country, size: Int, completion: @escaping (Result<Data, Error>?) -> Void)  {
        let urlSession = URLSession.shared
        
        guard let url = RequestUrl.imageDownload(country: country, size: size).url else {
            completion(Result.failure(NSError(domain: "Url not found", code: 1, userInfo: nil)))
            return
        }
        
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.task = urlSession.dataTask(with: url) { [weak self] data, _, error in
                guard self?.isCancelled == false else {
                    print("ApiRequestManager :: downloadImage :: request cancelled for image url = \(url.absoluteString)")
                    return
                }
                guard let data = data else {
                    completion(Result.failure(NSError(domain: error.debugDescription, code: 2, userInfo: nil)))
                    return
                }
                completion(.success(data))
            }
            self?.task?.resume()
        }
    }
    
    func cancelRequest() {
        print("ApiRequestManager :: cancelRequest :: Cancelling request = \(String(describing: task?.currentRequest?.debugDescription))")
        task?.cancel()
        isCancelled = true
    }
    
    deinit {
        print("deinit ApiRequestManager")
    }
}
