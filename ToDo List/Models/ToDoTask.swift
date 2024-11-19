//
//  ToDoTask.swift
//  ToDo List
//
//  Created by MyBook on 19.11.2024.
//

import Foundation

struct ToDoTask: Codable, Identifiable {
    var id: Int
    var todo: String
    var completed: Bool
    var userId: Int
    
    static var mock: ToDoTask {
        return ToDoTask(id: 123, todo: "something", completed: false, userId: 123)
    }
    
    func changeCompleted() -> ToDoTask {
        return ToDoTask(id: id, todo: todo, completed: !completed, userId: userId)
    }
}

struct ToDoList: Codable {
    var todos: [ToDoTask]
}
