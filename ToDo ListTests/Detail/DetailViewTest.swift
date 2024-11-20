//
//  DetailViewTest.swift
//  ToDo ListTests
//
//  Created by MyBook on 20.11.2024.
//

import XCTest
import ViewInspector
@testable import ToDo_List

extension DetailView: Inspectable {}

class DetailViewTests: XCTestCase {
    func testDetailViewDisplaysCorrectData() throws {
        // Arrange
        let task = ToDoTask(todo: "Test Title", text: "Test Description", creationDate: Date())
        let presenter = DetailPresenter(interactor: MockDetailInteractor(), task: task)
        let view = DetailView(presenter: presenter)

        // Act
        let textField = try view.inspect().find(ViewType.TextField.self)
        let textEditor = try view.inspect().find(ViewType.TextEditor.self)

        // Assert
        XCTAssertEqual(try textField.input(), "Test Title")
        XCTAssertEqual(try textEditor.text(), "Test Description")
    }

    func testDetailViewCallsUpdateOnDisappear() throws {
        // Arrange
        let task = ToDoTask(todo: "Test Title", text: "Test Description", creationDate: Date())
        let mockInteractor = MockDetailInteractor()
        let presenter = DetailPresenter(interactor: mockInteractor, task: task)
        let view = DetailView(presenter: presenter)

        // Act
        _ = view.body // Trigger SwiftUI lifecycle
        presenter.updateTaskOnDisappear()

        // Assert
        XCTAssertTrue(mockInteractor.updateTaskCalled, "onDisappear should call presenter's updateTaskOnDisappear.")
    }
}
