//
//  HomeView.swift
//  ToDo List
//
//  Created by MyBook on 19.11.2024.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    @ObservedObject var presenter: HomePresenter
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ScrollView(.vertical) {
                    ForEach(presenter.filteredToDoTasks) { toDoTask in
                        HomeCell(toDoTask: toDoTask, 
                        onDelete: {
                            presenter.delete(toDoTask: toDoTask)
                        }, onEdit: {
                            presenter.doToTask(toDoTask)
                        })
                            .padding(.horizontal)
                            .onTapGesture {
                                presenter.changeCompleted(toDoTask: toDoTask)
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
        .searchable(text: $presenter.searchText)
        .task {
            await presenter.loadData()
        }
    }
}


#Preview {
    HomeBuilder.build()
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
                Text("\(presenter.toDoTasks.count) задач")
                    .frame(height: 30)
            
            
                Spacer()
                
                NavigationLink {
                    presenter.addNewTask()
                } label: {
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding()
                        .foregroundStyle(.accent)
                        .overlay { Rectangle()
                                .opacity(0.01)
                        }
                }

            }
        }
    }
}
