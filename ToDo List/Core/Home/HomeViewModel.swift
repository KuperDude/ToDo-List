//
//  HomeViewModel.swift
//  ToDo List
//
//  Created by MyBook on 19.11.2024.
//

import SwiftUI

@Observable
class HomeViewModel {
    var toDoTasks: [ToDoTask] = []
    @ObservationIgnored private var apiManager = APIManager.instance
    
    @MainActor
    func getData() async {
        guard toDoTasks.isEmpty else { return }
        
        toDoTasks = await apiManager.getToDoTasks() ?? []
    }
}
