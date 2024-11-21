//
//  UIApplication.swift
//  ToDo List
//
//  Created by MyBook on 21.11.2024.
//

import SwiftUI

extension UIApplication {
    class func isFirstLaunch() -> Bool {
        if UserDefaults.standard.bool(forKey: "hasBeenLaunchedBeforeFlag") {
            return false
        } else {
            UserDefaults.standard.set(true, forKey: "hasBeenLaunchedBeforeFlag")
            UserDefaults.standard.synchronize()
            return true
        }
    }
    
    class func setFirstLaunch() {
        UserDefaults.standard.set(false, forKey: "hasBeenLaunchedBeforeFlag")
        UserDefaults.standard.synchronize()
    }
}
