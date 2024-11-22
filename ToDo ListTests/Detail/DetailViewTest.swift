//
//  DetailViewTest.swift
//  ToDo ListTests
//
//  Created by MyBook on 20.11.2024.
//

import XCTest
import ViewInspector
@testable import ToDo_List

class DetailViewTest: XCTestCase {
    func test_DetailView_DisplaysCorrectData() throws {
        // Given
        let task = ToDoTask(id: 123, todo: "Test Title", completed: false, text: "Test Description", creationDate: Date())
        let presenter = DetailPresenter(interactor: MockDetailInteractor(), task: task)
        let view = DetailView(presenter: presenter)

        // When
        let textField = try view.inspect().find(ViewType.TextField.self)
        let textEditor = try view.inspect().find(ViewType.TextEditor.self)

        // Then
        XCTAssertEqual(try textField.input(), "Test Title")
        XCTAssertNoThrow(textEditor)
    }

    func test_DetailView_CallsUpdateOnDisappear() throws {
        // Given
        let task = ToDoTask(id: 123, todo: "Test Title", completed: false, text: "Test Description", creationDate: Date())
        let mockInteractor = MockDetailInteractor()
        let presenter = DetailPresenter(interactor: mockInteractor, task: task)
        let view = DetailView(presenter: presenter)

        // When
        _ = view.body // Trigger SwiftUI lifecycle
        presenter.updateTaskOnDisappear()

        // Then
        XCTAssertTrue(mockInteractor.updateTaskCalled)
    }
}
