//
//  APIManager.swift
//  ToDo List
//
//  Created by MyBook on 19.11.2024.
//

import Foundation

protocol APIManagerProtocol {
    func getToDoTasks() async -> [ToDoTask]?
}

actor APIManager: APIManagerProtocol {
    
    static var instance = APIManager()
    
    func getToDoTasks() async -> [ToDoTask]? {
        let urlString = "https://dummyjson.com/todos"
        guard let url = URL(string: urlString) else { return nil }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if !NetworkManager.checkResponse(response: response) {
                return nil
            }
            
            let toDoList = try JSONDecoder().decode(ToDoList.self, from: data)
            
            return toDoList.todos
            
        } catch {
            print("Ошибка при работе с сетью: \(error)")
            return nil
        }
        
    }
}
