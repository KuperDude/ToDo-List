//
//  DetailPresenter.swift
//  ToDo List
//
//  Created by MyBook on 20.11.2024.
//

import Foundation

protocol DetailPresenterInput {
    func updateTaskOnDisappear()
    var title: String { get set }
    var text: String { get set }
    var creationDate: String { get }
}

class DetailPresenter: DetailPresenterInput, ObservableObject {
    private let interactor: DetailInteractorInput
    private let task: ToDoTask

    @Published var title: String
    @Published var text: String
    var creationDate: String

    init(interactor: DetailInteractorInput, task: ToDoTask) {
        self.interactor = interactor
        self.task = task
        self.title = task.todo
        self.creationDate = task.creationDate?.toFormattedString() ?? ""
        self.text = task.text ?? ""
    }

    func updateTaskOnDisappear() {
        interactor.updateTask(task, with: title, and: text)
    }
}
