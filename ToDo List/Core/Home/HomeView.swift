//
//  HomeView.swift
//  ToDo List
//
//  Created by MyBook on 19.11.2024.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ScrollView(.vertical) {
                    ForEach(vm.filteredToDoTasks) { toDoTask in
                        HomeCell(toDoTask: toDoTask, onDelete: {
                            vm.delete(toDoTask: toDoTask)
                        })
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            .onTapGesture {
                                vm.changeCompleted(toDoTask: toDoTask)
                            }
                        Divider()
                    }
                    .padding(.bottom, 100)
                }
                bottomBar
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .navigationTitle("Задачи")
        }
        .searchable(text: $vm.searchText)
        .task {
            await vm.getData()
        }
    }
}


#Preview {
    HomeView()
}

extension HomeView {
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
                Text("\(vm.toDoTasks.count) задач")
                    .frame(height: 30)
            
            
                Spacer()
                NavigationLink(destination: DetailView(toDoTask: ToDoTask.new)) {
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding()
                        .foregroundStyle(.accent)
                        .overlay {
                            Rectangle()
                                .opacity(0.01)
                        }
                }
            }
        }
    }
}
