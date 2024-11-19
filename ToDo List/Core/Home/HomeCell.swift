//
//  HomeCell.swift
//  ToDo List
//
//  Created by MyBook on 19.11.2024.
//

import SwiftUI

struct HomeCell: View {
    var title = "Почитать книгу"
    var text = "Составить список необходимых продуктов для ужина. Не забыть проверить, что уже есть в холожильнике"
    var date = "02/10/24"
    var completed = false
    
    init(toDoTask: ToDoTask) {
        self.title = toDoTask.todo
        self.text = ""
        self.date = "02/10/24"
        self.completed = toDoTask.completed
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: completed ? "circle" : "checkmark.circle")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(completed ? .secondary : .accent)
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .strikethrough(!completed, color: .secondary)
                    .font(.title)
                    .frame(height: 30)
                    
                Text(text)
                    .lineLimit(2)
                Text(date)
                    .foregroundStyle(.secondary)
            }
            .foregroundStyle(completed ? .primary : .secondary)
        }
        .contextMenu {
            contextMenu
        }
    }
}

#Preview {
    HomeCell(toDoTask: .mock)
}

extension HomeCell {
    private var contextMenu: some View {
        Group {
            NavigationLink(destination: DetailView(toDoTask: ToDoTask(id: 123, todo: title, completed: true, userId: 123))) {
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
