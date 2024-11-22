//
//  DetailInteractorTest.swift
//  ToDo ListTests
//
//  Created by MyBook on 20.11.2024.
//

import XCTest
@testable import ToDo_List

class DetailInteractorTest: XCTestCase {
    var interactor: DetailInteractor!
    var mockDataService: MockToDoDataService!

    override func setUp() {
        super.setUp()
        mockDataService = MockToDoDataService()
        interactor = DetailInteractor(dataService: mockDataService)
    }

    override func tearDown() {
        interactor = nil
        mockDataService = nil
        super.tearDown()
    }
    
    func test_DetailInteractor_updateTask_shuldUpdate() {
        // Given
        let mockTask = ToDoTask.mock

        // When
        interactor.updateTask(mockTask, with: "New Title", and: "New Text")

        // Then
        XCTAssertTrue(mockDataService.updateCalled)
        XCTAssertEqual(mockDataService.updatedTask?.todo, "New Title")
        XCTAssertEqual(mockDataService.updatedTask?.text, "New Text")
    }
    
    func test_DetailInteractor_updateTask_shuldNotUpdate() {
        // Given
        let mockTask = ToDoTask.mock

        // When
        interactor.updateTask(mockTask, with: "", and: "New Text")

        // Then
        XCTAssertFalse(mockDataService.updateCalled)
        XCTAssertNil(mockDataService.updatedTask?.todo)
        XCTAssertNil(mockDataService.updatedTask?.text)
    }
}

class MockToDoDataService: ToDoDataService {
    var updateCalled = false
    var updatedTask: ToDoTask?
    
    override func updateTasks(toDoTask: ToDo_List.ToDoTask, status: ToDo_List.ToDoDataService.Status) {
        updateCalled = true
        updatedTask = toDoTask
    }

}
