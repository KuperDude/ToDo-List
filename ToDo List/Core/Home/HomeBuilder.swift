//
//  HomeBuilder.swift
//  ToDo List
//
//  Created by MyBook on 20.11.2024.
//

import SwiftUI

struct HomeBuilder {
    static func build() -> some View {
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(interactor: interactor, router: router)
        return HomeView(presenter: presenter)
    }
}
