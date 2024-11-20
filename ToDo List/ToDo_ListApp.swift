//
//  ToDo_ListApp.swift
//  ToDo List
//
//  Created by MyBook on 19.11.2024.
//

import SwiftUI
import SwiftfulRouting

@main
struct ToDo_ListApp: App {
    var body: some Scene {
        WindowGroup {
            //RouterView { _ in
                HomeBuilder.build()
            //}
        }
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
