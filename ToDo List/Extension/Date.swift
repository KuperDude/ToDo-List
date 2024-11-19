//
//  Date.swift
//  ToDo List
//
//  Created by MyBook on 20.11.2024.
//

import Foundation

extension Date {
    func toFormattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        return dateFormatter.string(from: self)
    }
}
