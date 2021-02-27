//
//  ApiRequestManager.swift
//  MBCountries
//
//  Created by Parimal Modi on 27/02/21.
//

import Foundation

enum RequestUrl {
    case countriesData
    
    var url: URL? {
        switch self {
        case .countriesData:
            return URL(string: "https://connect.mindbodyonline.com/rest/worldregions/country")
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
                print("ApiRequestManager :: requestData :: request active for data url = \(url.absoluteString)")
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
            print("ApiRequestManager :: requestData :: Starting request for data url = \(url.absoluteString)")
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
