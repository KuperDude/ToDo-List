//
//  HomeView.swift
//  ToDo List
//
//  Created by MyBook on 19.11.2024.
//

import SwiftUI

struct HomeView: View {
    
    @State var vm = HomeViewModel()
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ScrollView(.vertical) {
                    ForEach(vm.toDoTasks) { toDoTask in
                        HomeCell(toDoTask: toDoTask)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            .contextMenu {
                                contextMenu
                            }
                        Divider()
                    }
                }
                bottomBar
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .navigationTitle("Задачи")
        }
        .searchable(text: $searchText)
        .task {
            await vm.getData()
        }
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
    private var bottomBar: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .foregroundStyle(Color(red: 39/255, green: 39/255, blue: 41/255))
                .frame(height: 100)
            HStack {
                Rectangle()
                    .frame(width: 30, height: 30)
                    .padding()
                    .opacity(0)
                Spacer()
                Text("7 задач")
                    .frame(height: 30)
            
            
                Spacer()
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding()
                    .foregroundStyle(.accent)
            }
        }
    }
}
