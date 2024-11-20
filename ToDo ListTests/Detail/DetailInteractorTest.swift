//
//  DetailInteractorTest.swift
//  ToDo ListTests
//
//  Created by MyBook on 20.11.2024.
//

import XCTest
@testable import ToDo_List

class DetailInteractorTests: XCTestCase {
    func testUpdateTaskCallsExpectedMethod() {
        // Arrange
        let mockTask = ToDoTask.mock
        let mockRepository = MockTaskRepository()
        let interactor = DetailInteractor()

        // Act
        interactor.updateTask(mockTask, with: "New Title", and: "New Text")

        // Assert
        XCTAssertTrue(mockRepository.updateCalled, "updateTask should call the repository update method.")
        XCTAssertEqual(mockRepository.updatedTask?.todo, "New Title")
        XCTAssertEqual(mockRepository.updatedTask?.text, "New Text")
    }
}

// Mock Repository
class MockTaskRepository: TaskRepositoryProtocol {
    var updateCalled = false
    var updatedTask: ToDoTask?

    func updateTask(_ task: ToDoTask) {
        updateCalled = true
        updatedTask = task
    }
}
