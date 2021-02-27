//
//  ExtensionUtility.swift
//  MBCountries
//
//  Created by Parimal Modi on 27/02/21.
//

import Foundation

extension Thread {
    public static func executeOnMainThread(callback: @escaping () -> Void) {
        if isMainThread {
            callback()
            return
        }
        DispatchQueue.main.async {
            callback()
        }
    }
}
