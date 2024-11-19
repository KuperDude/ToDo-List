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
    
    var cancellables = Set<AnyCancellable>()
    
    @MainActor
    func getData() async {
        guard toDoTasks.isEmpty else { return }
        
        toDoTasks = await apiManager.getToDoTasks() ?? []
        filteredToDoTasks = toDoTasks
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
                
                if text == "" {
                    self?.filteredToDoTasks = toDoTasks
                } else {
                    self?.filteredToDoTasks = toDoTasks.filter({ $0.todo.capitalized.contains(text.capitalized) })
                }
            }
            .store(in: &cancellables)
            
    }
}

//MARK: - User Intent(s)
extension HomeViewModel {
    func changeCompleted(at id: Int) {
        guard 
            let filteredIndex = filteredToDoTasks.firstIndex(where: { $0.id == id }),
            let index = toDoTasks.firstIndex(where: { $0.id == id })
        else { return }
        
        filteredToDoTasks[filteredIndex] = filteredToDoTasks[filteredIndex].changeCompleted()
        toDoTasks[index] = toDoTasks[index].changeCompleted()
    }
}
