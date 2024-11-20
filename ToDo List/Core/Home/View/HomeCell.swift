//
//  HomeCell.swift
//  ToDo List
//
//  Created by MyBook on 19.11.2024.
//

import SwiftUI

struct HomeCell: View {
    var toDoTask: ToDoTask
    
    var onDelete: ()->Void
    var onEdit: ()->AnyView
    
    init(toDoTask: ToDoTask, onDelete: @escaping ()->Void, onEdit: @escaping ()->AnyView) {
        self.toDoTask = toDoTask
        self.onDelete = onDelete
        self.onEdit = onEdit
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: toDoTask.completed ? "checkmark.circle" : "circle")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(toDoTask.completed ? .accent : .secondary)
            VStack(alignment: .leading, spacing: 8) {
                Text(toDoTask.todo)
                    .strikethrough(toDoTask.completed, color: .secondary)
                    .font(.title)
                    .frame(height: 30)
                    
                Text(toDoTask.text ?? "")
                    .lineLimit(2)
                Text(toDoTask.creationDate?.toFormattedString() ?? "")
                    .foregroundStyle(.secondary)
            }
            .foregroundStyle(toDoTask.completed ? .secondary : .primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(content: {
            Rectangle()
                .opacity(0.01)
        })
        .contextMenu {
            contextMenu
        }
       
    }
}

#Preview {
    HomeCell(toDoTask: .mock, onDelete: {}, onEdit: {AnyView(Text(""))})
}

extension HomeCell {
    private var contextMenu: some View {
        Group {
            NavigationLink {
                onEdit()
            } label: {
                Label("Редактировать", systemImage: "pencil")
            }

//            Button(action: onEdit) {
//                Label("Редактировать", systemImage: "pencil")
//            }
            
            ShareLink(item: "\(toDoTask.todo)\n\(toDoTask.text ?? "")") {
                Label("Поделиться", systemImage: "cloud")
            }
            Button(role: .destructive, action: onDelete) {
                Label("Удалить", systemImage: "trash")
                    .foregroundStyle(.red)
            }
        }
    }
}
