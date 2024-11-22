//
//  HomeViewTest.swift
//  ToDo ListTests
//
//  Created by MyBook on 22.11.2024.
//

import XCTest
import ViewInspector
import SwiftUI
@testable import ToDo_List

class HomeViewTests: XCTestCase {
    var presenter: MockHomePresenter!
    var view: HomeView!
    
    override func setUp() {
        super.setUp()
        presenter = MockHomePresenter(interactor: HomeInteractor(), router: HomeRouter())
        view = HomeView(presenter: presenter)
    }
    
    override func tearDown() {
        presenter = nil
        view = nil
        super.tearDown()
    }
    
    func test_HomeView_TaskTapCompletesTask() throws {
        // Given
        let task = ToDoTask(id: 1, todo: "Task 1", completed: false, text: "Description 1", creationDate: Date())
        presenter.filteredToDoTasks = [task]

        let inspectedView = try view.inspect()
        let taskCell = try inspectedView.find(HomeCell.self)
        
        // When
        try taskCell.callOnTapGesture()
        
        // Then
        XCTAssertEqual(presenter.completedTasks.count, 1)
        XCTAssertEqual(presenter.completedTasks.first?.id, 1)
    }
    
    func test_HomeView_TabBar_DisplaysCorrectTaskCount() throws {
        // Given
        presenter.toDoTasks = [
            ToDoTask(id: 1, todo: "Task 1", completed: false, text: "Description 1", creationDate: Date()),
            ToDoTask(id: 2, todo: "Task 2", completed: true, text: "Description 2", creationDate: Date())
        ]
        
        // When
        let inspectedView = try view.inspect()
        let tabBar = try inspectedView.find(ViewType.Text.self, where: { try $0.string().contains("2 задач") })
        
        // Then
        XCTAssertNotNil(tabBar)
        XCTAssertEqual(try tabBar.string(), "2 задач")
    }
}

class MockHomePresenter: HomePresenter {
    var completedTasks: [ToDoTask] = []
    var addNewTaskCalled = false
    
    override func changeCompleted(toDoTask: ToDoTask) {
        completedTasks.append(toDoTask)
    }
    
    override func addNewTask() -> AnyView {
        addNewTaskCalled = true
        return AnyView(EmptyView())
    }
}
