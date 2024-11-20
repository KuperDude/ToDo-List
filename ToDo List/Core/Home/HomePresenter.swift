//
//  HomePresenter.swift
//  ToDo List
//
//  Created by MyBook on 20.11.2024.
//

import Foundation
import Combine
import SwiftfulRouting
import SwiftUI

class HomePresenter: ObservableObject {
    @Published var toDoTasks: [ToDoTask] = []
    @Published var filteredToDoTasks: [ToDoTask] = []
    @Published var searchText: String = ""

    private let interactor: HomeInteractorInput
    private let router: HomeRouterInput

    private var cancellables = Set<AnyCancellable>()

    init(interactor: HomeInteractorInput, router: HomeRouterInput) {
        self.interactor = interactor
        self.router = router
        setupSubscribers()
    }

    func setupSubscribers() {
        $searchText
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                guard let self = self else { return }
                self.filteredToDoTasks = self.interactor.filterTasks(by: text)
            }
            .store(in: &cancellables)
        
        interactor.toDoTasksPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] returnedTasks in
                guard let self = self else { return }
                self.toDoTasks = returnedTasks
                self.filteredToDoTasks = self.interactor.filterTasks(by: searchText)
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    func loadData() async {
        await interactor.loadData()
        toDoTasks = interactor.toDoTasks
        filteredToDoTasks = toDoTasks
    }

    func changeCompleted(toDoTask: ToDoTask) {
        interactor.changeCompleted(toDoTask: toDoTask)
    }

    func delete(toDoTask: ToDoTask) {
        interactor.deleteTask(toDoTask: toDoTask)
    }

    func addNewTask() -> AnyView {
        router.navigateToAddTask()
    }
    func doToTask(_ task: ToDoTask) -> AnyView {
        router.navigateToTaskDetail(for: task)
    }
}

