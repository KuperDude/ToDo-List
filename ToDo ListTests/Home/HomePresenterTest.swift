//
//  HomePresenterTest.swift
//  ToDo ListTests
//
//  Created by MyBook on 22.11.2024.
//

import XCTest
import Combine
@testable import ToDo_List
import SwiftUI

class HomePresenterTest: XCTestCase {
    var presenter: HomePresenter!
    var mockInteractor: MockHomeInteractor!
    var mockRouter: MockHomeRouter!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = Set<AnyCancellable>()
        
        mockInteractor = MockHomeInteractor()
        mockRouter = MockHomeRouter()
        
        presenter = HomePresenter(interactor: mockInteractor, router: mockRouter)
    }

    override func tearDown() {
        presenter = nil
        mockInteractor = nil
        mockRouter = nil
        cancellables = nil
        super.tearDown()
    }

    func test_HomePresenter_searchText_shouldFiltering() {
        // Given
        let task1 = ToDoTask(id: 1, todo: "Buy groceries", completed: false, text: "Milk, Bread")
        let task2 = ToDoTask(id: 2, todo: "Write code", completed: false, text: "Finish HomePresenter")
        
        mockInteractor.toDoTasks = [task1, task2]
        
        // When
        presenter.searchText = "code"
        
        
        // Then
        let expectation = self.expectation(description: "Waiting for load data")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            XCTAssertEqual(self.presenter.filteredToDoTasks.count, 1)
            XCTAssertEqual(self.presenter.filteredToDoTasks.first?.todo, "Write code")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }

    func test_HomePresenter_LoadData() async {
        // Given
        let task1 = ToDoTask(id: 1, todo: "Buy groceries", completed: false, text: "Milk, Bread")
        let task2 = ToDoTask(id: 2, todo: "Write code", completed: false, text: "Finish HomePresenter")
        
        mockInteractor.toDoTasks = [task1, task2]
        
        // When
        await presenter.loadData()

        // Then
        XCTAssertEqual(presenter.toDoTasks.count, 2)
        XCTAssertEqual(presenter.toDoTasks.first?.todo, "Buy groceries")
    }

    func test_HomePresenter_ChangeCompleted_ShouldChangeState() {
        // Given
        let task = ToDoTask(id: 1, todo: "Buy groceries", completed: false, text: "Milk, Bread")
        
        // When
        presenter.changeCompleted(toDoTask: task)
        
        // Then
        XCTAssertTrue(mockInteractor.didChangeCompleted)
    }

    func test_HomePresenter_DeleteTask_ShouldDelete() {
        // Given
        let task = ToDoTask(id: 1, todo: "Buy groceries", completed: false, text: "Milk, Bread")
        presenter.toDoTasks = [task]
        presenter.filteredToDoTasks = [task]
        
        // When
        presenter.delete(toDoTask: task)
        
        // Then
        XCTAssertTrue(presenter.filteredToDoTasks.isEmpty)
        XCTAssertTrue(mockInteractor.didDeleteTask)
    }

    func test_HomePresenter_AddNewTask_shouldNavigate() {
        // When
        _ = presenter.addNewTask()
        
        // Then
        XCTAssertTrue(mockRouter.didNavigateToAddTask)
    }

    func test_HomePresenter_GoToTaskDetail_shouldNavigate() {
        // Given
        let task = ToDoTask(id: 1, todo: "Buy groceries", completed: false, text: "Milk, Bread")
        
        // When
        _ = presenter.goToTask(task)
        
        // Then
        XCTAssertTrue(mockRouter.didNavigateToTaskDetail)
    }
}

class MockHomeInteractor: HomeInteractorInput {
    var toDoTasks: [ToDoTask] = []
    var toDoTasksPublisher: AnyPublisher<[ToDoTask], Never> {
        Just(toDoTasks).eraseToAnyPublisher()
    }
    var didChangeCompleted = false
    var didDeleteTask = false

    func loadData() async {}
    
    func filterTasks(by searchText: String) -> [ToDoTask] {
        return toDoTasks.filter { $0.todo.contains(searchText) }
    }

    func changeCompleted(toDoTask: ToDoTask) {
        didChangeCompleted = true
    }

    func deleteTask(toDoTask: ToDoTask) {
        didDeleteTask = true
    }
}

class MockHomeRouter: HomeRouterInput {
    var didNavigateToAddTask = false
    var didNavigateToTaskDetail = false

    func navigateToAddTask() -> AnyView {
        didNavigateToAddTask = true
        return AnyView(EmptyView())
    }

    func navigateToTaskDetail(for task: ToDoTask) -> AnyView {
        didNavigateToTaskDetail = true
        return AnyView(EmptyView())
    }
}
