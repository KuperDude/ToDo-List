//
//  DetailPresenterTest.swift
//  ToDo ListTests
//
//  Created by MyBook on 20.11.2024.
//

import XCTest
@testable import YourAppModule

class DetailPresenterTests: XCTestCase {
    func testPresenterInitializesCorrectly() {
        // Arrange
        let task = ToDoTask(todo: "Test Task", text: "Task Description", creationDate: Date())
        let mockInteractor = MockDetailInteractor()

        // Act
        let presenter = DetailPresenter(interactor: mockInteractor, task: task)

        // Assert
        XCTAssertEqual(presenter.title, "Test Task")
        XCTAssertEqual(presenter.text, "Task Description")
    }

    func testPresenterUpdatesTaskOnDisappear() {
        // Arrange
        let task = ToDoTask(todo: "Test Task", text: "Task Description", creationDate: Date())
        let mockInteractor = MockDetailInteractor()
        let presenter = DetailPresenter(interactor: mockInteractor, task: task)
        presenter.title = "Updated Title"
        presenter.text = "Updated Text"

        // Act
        presenter.updateTaskOnDisappear()

        // Assert
        XCTAssertTrue(mockInteractor.updateTaskCalled, "updateTaskOnDisappear should call interactor's update method.")
        XCTAssertEqual(mockInteractor.updatedTask?.todo, "Updated Title")
        XCTAssertEqual(mockInteractor.updatedTask?.text, "Updated Text")
    }
}

// Mock Interactor
class MockDetailInteractor: DetailInteractorInput {
    var updateTaskCalled = false
    var updatedTask: ToDoTask?

    func updateTask(_ task: ToDoTask, with title: String, and text: String) {
        updateTaskCalled = true
        updatedTask = ToDoTask(todo: title, text: text, creationDate: task.creationDate)
    }
}
