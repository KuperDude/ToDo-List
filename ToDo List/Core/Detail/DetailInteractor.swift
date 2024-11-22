//
//  DetailInteractor.swift
//  ToDo List
//
//  Created by MyBook on 20.11.2024.
//

import Foundation

protocol DetailInteractorInput {
    func updateTask(_ task: ToDoTask, with title: String, and text: String)
}

class DetailInteractor: DetailInteractorInput {
    let dataService: ToDoDataServiceProtocol
    
    init(dataService: ToDoDataServiceProtocol = ToDoDataService.instance) {
        self.dataService = dataService
    }

    func updateTask(_ task: ToDoTask, with title: String, and text: String) {   
        guard !title.isEmpty else { return }
        let updatedTask = task.changeTitleAndText(title: title, text: text)
        dataService.updateTasks(toDoTask: updatedTask, status: .update)
    }
}
