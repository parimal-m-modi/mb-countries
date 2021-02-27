//
//  BaseViewController.swift
//  MBCountries
//
//  Created by Parimal Modi on 27/02/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    private var loadingStateView: UIView?
    
    func showLoadingView() {
        Thread.executeOnMainThread { [weak self] in
            if let strongSelf: BaseViewController = self {
                if strongSelf.loadingStateView == nil {
                    let parentView: UIView = strongSelf.view
                    let loadingView: UIView = UIView()
                    var frame: CGRect = parentView.frame
                    frame.origin.y = 0
                    loadingView.frame = frame
                    loadingView.alpha = 0.7
                    loadingView.backgroundColor = UIColor.systemBackground

                    let activityIndicatorView = UIActivityIndicatorView(style: .large)
                    activityIndicatorView.center = loadingView.center
                    activityIndicatorView.startAnimating()
                    loadingView.addSubview(activityIndicatorView)
                    parentView.addSubview(loadingView)
                    strongSelf.loadingStateView = loadingView
                }
            }
        }
    }

    func hideLoadingView() {
        Thread.executeOnMainThread { [weak self] in
            if let strongSelf: BaseViewController = self {
                strongSelf.loadingStateView?.removeFromSuperview()
                strongSelf.loadingStateView = nil
            }
        }
    }
}
