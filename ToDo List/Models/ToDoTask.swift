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
    
    var text: String?
    var creationDate: Date?
    
    init(id: Int, todo: String, completed: Bool, text: String? = nil, creationDate: Date? = nil) {
        self.id = id
        self.todo = todo
        self.completed = completed
        self.text = text
        self.creationDate = creationDate
    }
    
    init(entity: ToDoTaskEntity) {
        self.id = Int(entity.taskID)
        self.todo = entity.title ?? ""
        self.completed = entity.completion
        self.text = entity.text
        self.creationDate = entity.creationDate
    }
    
    static var mock: ToDoTask {
        return ToDoTask(id: 123, todo: "something", completed: false)
    }
    
    func changeCompleted() -> ToDoTask {
        return ToDoTask(id: id, todo: todo, completed: !completed, text: text, creationDate: creationDate)
    }
    
    func changeTitleAndText(title: String, text: String?) -> ToDoTask {
        return ToDoTask(id: id, todo: title, completed: completed, text: text, creationDate: creationDate)
    }
}

struct ToDoList: Codable {
    var todos: [ToDoTask]
}
