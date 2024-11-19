//
//  HomeViewModel.swift
//  ToDo List
//
//  Created by MyBook on 19.11.2024.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var toDoTasks: [ToDoTask] = []
    @Published var filteredToDoTasks: [ToDoTask] = []
    @Published var searchText: String = ""
    private var apiManager = APIManager.instance
    private var dataService = ToDoDataService.instance
    
    var cancellables = Set<AnyCancellable>()
    
    @MainActor
    func getData() async {
        if dataService.savedEntities.isEmpty {
            guard toDoTasks.isEmpty else { return }
            
            toDoTasks = await apiManager.getToDoTasks() ?? []
            filteredToDoTasks = toDoTasks
            
            for task in self.toDoTasks {
                self.dataService.updateTasks(toDoTask: task, status: .update)
            }
        }
    }
    
    init() {
        subscribers()
    }
    
    func subscribers() {
        
        $searchText
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] text in
                
                guard let toDoTasks = self?.toDoTasks else { return }
                
                if text.isEmpty {
                    self?.filteredToDoTasks = toDoTasks
                } else {
                    self?.filteredToDoTasks = toDoTasks.filter({ $0.todo.capitalized.contains(text.capitalized) })
                }
            }
            .store(in: &cancellables)
        
        dataService.$savedEntities
            .map(mapAllEntityToToDoTasks)
            .sink { [weak self] returnedTasks in
                guard let self = self else { return }
                self.toDoTasks = returnedTasks                
                if self.searchText.isEmpty {
                    self.filteredToDoTasks = toDoTasks
                } else {
                    self.filteredToDoTasks = toDoTasks.filter({ $0.todo.capitalized.contains(self.searchText.capitalized) })
                }
            }
            .store(in: &cancellables)
            
    }
    
    private func mapAllEntityToToDoTasks(allTasks: [ToDoTaskEntity]) -> [ToDoTask] {
        allTasks.map({ ToDoTask(entity: $0) })
    }
}

//MARK: - User Intent(s)
extension HomeViewModel {
    func changeCompleted(toDoTask: ToDoTask) {
        dataService.updateTasks(toDoTask: toDoTask.changeCompleted(), status: .update)
    }
    
    func delete(toDoTask: ToDoTask) {
        dataService.updateTasks(toDoTask: toDoTask, status: .delete)
    }
}
