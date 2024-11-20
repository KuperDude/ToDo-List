//
//  DetailBuilder.swift
//  ToDo List
//
//  Created by MyBook on 20.11.2024.
//

import SwiftUI

struct DetailBuilder {
    static func build(with task: ToDoTask) -> some View {
        let interactor = DetailInteractor()
        let presenter = DetailPresenter(interactor: interactor, task: task)
        return DetailView(presenter: presenter)
    }
}
