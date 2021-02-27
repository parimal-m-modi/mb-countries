//
//  ScreenDisplayUtilities.swift
//  MBCountries
//
//  Created by Parimal Modi on 27/02/21.
//

import UIKit

final class ScreenDisplayUtilities {
    
    static func displayCountryDetailsScreen(cellViewModel: CountryCellViewModel) {
        DispatchQueue.main.async() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let viewController = storyboard.instantiateViewController(identifier: "CountryDetailsViewController") as? CountryDetailsViewController,
               let sceneDelegate: SceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                viewController.setCountryCellViewModel(cellViewModel)
                (sceneDelegate.window?.rootViewController as? UINavigationController)?.pushViewController(viewController,
                                                                                                          animated: true)
            }
        }
    }
    
    static func displayRetryAlert(title: String = "Error",
                                  msg: String,
                                  retryAction: @escaping () -> Void,
                                  cancelAction: @escaping () -> Void) {
        let alertController = UIAlertController(title: title,
                                                                   message: msg,
                                                                   preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { _ in
            retryAction()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in
            cancelAction()
        }
        alertController.addAction(retryAction)
        alertController.addAction(cancelAction)
        DispatchQueue.main.async {
            if let sceneDelegate: SceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                (sceneDelegate.window?.rootViewController as? UINavigationController)?.topViewController?.present(alertController,
                                                                                                                 animated: true,
                                                                                                                 completion: nil)
            }
        }
    }
}
