//
//  DetailPresenterTest.swift
//  ToDo ListTests
//
//  Created by MyBook on 20.11.2024.
//

import XCTest
@testable import ToDo_List

class DetailPresenterTest: XCTestCase {
    func test_DetailPresenter_InitializesCorrectly() {
        // Given
        let task = ToDoTask(id: 123, todo: "Test Task", completed: false, text: "Task Description", creationDate: Date())
        let mockInteractor = MockDetailInteractor()

        // When
        let presenter = DetailPresenter(interactor: mockInteractor, task: task)

        // Then
        XCTAssertEqual(presenter.title, "Test Task")
        XCTAssertEqual(presenter.text, "Task Description")
        XCTAssertEqual(presenter.creationDate, task.creationDate?.toFormattedString())
    }

    func test_DetailPresenter_UpdatesTaskOnDisappear() {
        // Given
        let task = ToDoTask.mock
        let mockInteractor = MockDetailInteractor()
        let presenter = DetailPresenter(interactor: mockInteractor, task: task)
        presenter.title = "Updated Title"
        presenter.text = "Updated Text"

        // When
        presenter.updateTaskOnDisappear()

        // Then
        XCTAssertTrue(mockInteractor.updateTaskCalled)
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
        updatedTask = ToDoTask(id: 123, todo: title, completed: false, text: text, creationDate: task.creationDate)
    }
}
