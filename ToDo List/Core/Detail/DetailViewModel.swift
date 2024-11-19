//
//  DetailViewModel.swift
//  ToDo List
//
//  Created by MyBook on 20.11.2024.
//

import Foundation

class DetailViewModel: ObservableObject {
    private var dataService = ToDoDataService.instance
    
    @Published var title: String
    @Published var text: String
    
    init(title: String, text: String) {
        self.title = title
        self.text = text
    }
    
}

//MARK: - User Intents
extension DetailViewModel {
    func update(toDoTask: ToDoTask) {
        dataService.updateTasks(toDoTask: toDoTask.changeTitleAndText(title: title, text: text), status: .update)
    }
}
