//
//  DetailView.swift
//  ToDo List
//
//  Created by MyBook on 19.11.2024.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var vm: DetailViewModel
    
    var toDoTask: ToDoTask
    
    init(toDoTask: ToDoTask) {
        self.toDoTask = toDoTask
        self._vm = StateObject(wrappedValue: DetailViewModel(title: toDoTask.todo, text: toDoTask.text ?? ""))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            TextField("Введите заголовок", text: $vm.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(toDoTask.creationDate?.toFormattedString() ?? "")
                .foregroundStyle(.secondary)
            
            TextEditor(text: $vm.text)
            
        }
        .padding(.horizontal)
        .onDisappear {
            if vm.title != "" {
                vm.update(toDoTask: toDoTask)
            }
        }
    }
}

#Preview {
    DetailView(toDoTask: .mock)
}
