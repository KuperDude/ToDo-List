//
//  Persistence.swift
//  ToDo List
//
//  Created by MyBook on 19.11.2024.
//

import Foundation
import CoreData

class ToDoDataService {
    
    static var instance = ToDoDataService()
    
    private let container: NSPersistentContainer
    private let containerName: String = "ToDo_List"
    private let entityName = "ToDoTaskEntity"
    
    @Published var savedEntities: [ToDoTaskEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
            self.getTasks()
        }
    }
    
    enum Status {
        case delete
        case update
    }
    
    //MARK: PUBLIC
    
    func updateTasks(toDoTask: ToDoTask, status: Status) {
        if let entity = savedEntities.first(where: { $0.taskID == toDoTask.id }) {
            
            switch status {
            case .update: update(entity: entity, toDoTask: toDoTask)
            case .delete: delete(entity: entity)
            }
        } else {
            add(toDoTask: toDoTask)
        }
    }
    
    //MARK: PRIVATE
    
    private func getTasks() {
        let request = NSFetchRequest<ToDoTaskEntity>(entityName: entityName)
        let sortDescriptor = NSSortDescriptor(key: "taskID", ascending: false)
        
        request.sortDescriptors = [sortDescriptor]
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Portfolio Entities. \(error)")
        }
    }
    
    private func add(toDoTask: ToDoTask) {        
        let entity = ToDoTaskEntity(context: container.viewContext)
        entity.taskID = Int16(toDoTask.id)
        entity.completion = toDoTask.completed
        entity.creationDate = Date.now
        entity.title = toDoTask.todo
        entity.text = toDoTask.text
        applyChanges()
    }
    
    private func update(entity: ToDoTaskEntity, toDoTask: ToDoTask) {
        entity.completion = toDoTask.completed
        entity.title = toDoTask.todo
        entity.text = toDoTask.text
        applyChanges()
    }
    
    private func delete(entity: ToDoTaskEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving to Core Data. \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getTasks()
    }
}
