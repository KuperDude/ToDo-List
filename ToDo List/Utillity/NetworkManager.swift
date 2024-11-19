//
//  NetworkManager.swift
//  ToDo List
//
//  Created by MyBook on 19.11.2024.
//

import Foundation

actor NetworkManager {
    
    static func checkResponse(response: URLResponse) -> Bool {
        guard
            let urlResponse = response as? HTTPURLResponse,
            urlResponse.statusCode >= 200 && urlResponse.statusCode < 300
        else { return false }
        
        return true
    }
}
