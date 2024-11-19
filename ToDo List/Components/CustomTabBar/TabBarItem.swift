//
//  TabBarItem.swift
//  LMS_Mobile
//
//  Created by MyBook on 03.07.2024.
//

import Foundation
import SwiftUI

enum TabBarItem: Hashable {
    case courses, profile
    
    var iconName: String {
        switch self {
        case .courses: return "graduationcap"
        case .profile: return "person"
        }
    }
    
    var title: String {
        switch self {
        case .courses: return "Курсы"
        case .profile: return "Профиль"
        }
    }
    
    var color: Color {
        switch self {
        case .courses: return Color.red
        case .profile: return Color.orange
        }
    }
}
