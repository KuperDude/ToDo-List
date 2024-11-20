//
//  HomeRouter.swift
//  ToDo List
//
//  Created by MyBook on 20.11.2024.
//

import SwiftUI
import SwiftfulRouting

protocol HomeRouterInput {
    func navigateToAddTask() -> AnyView
    func navigateToTaskDetail(for task: ToDoTask) -> AnyView
}

class HomeRouter: HomeRouterInput {
    
    func navigateToAddTask() -> AnyView {
        AnyView(DetailBuilder.build(with: ToDoTask.new))
    }
    
    func navigateToTaskDetail(for task: ToDoTask) -> AnyView  {
        AnyView(DetailBuilder.build(with: task))
    }
}
