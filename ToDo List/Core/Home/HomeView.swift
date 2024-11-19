//
//  HomeView.swift
//  ToDo List
//
//  Created by MyBook on 19.11.2024.
//

import SwiftUI

struct HomeView: View {
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ScrollView(.vertical) {
                    ForEach(0..<10) { _ in
                        HomeCell()
                            .padding(.horizontal)
                            .contextMenu {
                                contextMenu
                            }
                        Divider()
                    }
                }
                Rectangle()
                    .foregroundStyle(.gray)
                    .frame(height: 100)
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .navigationTitle("Задачи")
        }
        .searchable(text: $searchText)
    }
}

#Preview {
    HomeView()
}

extension HomeView {
    private var contextMenu: some View {
        Group {
            NavigationLink(destination: DetailView()) {
                Label("Редактировать", systemImage: "pencil")
            }
            Button(action: {}) {
                Label("Поделиться", systemImage: "cloud")
            }
            Button(role: .destructive, action: {}) {
                Label("Удалить", systemImage: "trash")
                    .foregroundStyle(.red)
            }
        }
    }
}
