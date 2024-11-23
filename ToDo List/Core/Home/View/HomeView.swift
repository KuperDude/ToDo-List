//
//  HomeView.swift
//  ToDo List
//
//  Created by MyBook on 19.11.2024.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    @Namespace var namespace
    @ObservedObject var presenter: HomePresenter
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ScrollView(.vertical) {
                    ForEach(presenter.filteredToDoTasks) { toDoTask in
                        HomeCell(toDoTask: toDoTask, 
                        onDelete: {
                            withAnimation(.spring) {
                                presenter.delete(toDoTask: toDoTask)
                            }
                        }, onEdit: {
                            presenter.goToTask(toDoTask)
                        })
                            .padding(.horizontal)
                            .onTapGesture {
                                presenter.changeCompleted(toDoTask: toDoTask)
                            }
                            .transition(.move(edge: .leading))
                            .matchedGeometryEffect(id: toDoTask.id, in: namespace)
                        Divider()
                    }
                    .padding(.bottom, 100)
                }
                tabBar
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
    private var tabBar: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .foregroundStyle(Color("tabBar"))
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
                                .opacity(0.001)
                        }
                }

            }
        }
    }
}
