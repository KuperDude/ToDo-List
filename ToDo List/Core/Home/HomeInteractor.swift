//
//  HomeInteractor.swift
//  ToDo List
//
//  Created by MyBook on 20.11.2024.
//

import Foundation
import Combine
import SwiftUI

protocol HomeInteractorInput {
    var toDoTasks: [ToDoTask] { get }
    var toDoTasksPublisher: AnyPublisher<[ToDoTask], Never> { get }
    func loadData() async
    func filterTasks(by searchText: String) -> [ToDoTask]
    func changeCompleted(toDoTask: ToDoTask)
    func deleteTask(toDoTask: ToDoTask)
}

class HomeInteractor: HomeInteractorInput {
    private let apiManager: APIManagerProtocol
    private let dataService: ToDoDataService

    var toDoTasks: [ToDoTask] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    private let toDoTasksSubject = CurrentValueSubject<[ToDoTask], Never>([])
    
    var toDoTasksPublisher: AnyPublisher<[ToDoTask], Never> { toDoTasksSubject.eraseToAnyPublisher() }

    init(apiManager: APIManagerProtocol = APIManager.instance, dataService: ToDoDataService = .instance) {
        self.apiManager = apiManager
        self.dataService = dataService
        setupSubscribers()
    }

    func loadData() async {
        if await UIApplication.isFirstLaunch() {
            guard toDoTasks.isEmpty else { return }
            toDoTasks = await apiManager.getToDoTasks() ?? []
            if toDoTasks.isEmpty {
                await UIApplication.setFirstLaunch()
            }
            for task in toDoTasks {
                dataService.updateTasks(toDoTask: task, status: .update)
            }
        } else {            
            toDoTasks = dataService.savedEntities.map { ToDoTask(entity: $0) }
        }
    }
    
    func setupSubscribers() {
        dataService.$savedEntities
            .map(mapAllEntityToToDoTasks)
            .sink { [weak self] returnedTasks in
                guard let self = self else { return }
                self.toDoTasks = returnedTasks
                self.toDoTasksSubject.send(returnedTasks)
            }
            .store(in: &cancellables)
    }
    
    private func mapAllEntityToToDoTasks(allTasks: [ToDoTaskEntity]) -> [ToDoTask] {
        allTasks.map({ ToDoTask(entity: $0) })
    }

    func filterTasks(by searchText: String) -> [ToDoTask] {
        guard !searchText.isEmpty else { return toDoTasks }
        
        return toDoTasks.filter { $0.todo.localizedCaseInsensitiveContains(searchText) }
    }

    func changeCompleted(toDoTask: ToDoTask) {
        let updatedTask = toDoTask.changeCompleted()
        dataService.updateTasks(toDoTask: updatedTask, status: .update)
    }

    func deleteTask(toDoTask: ToDoTask) {
        dataService.updateTasks(toDoTask: toDoTask, status: .delete)
    }
}

