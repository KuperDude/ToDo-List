//
//  DetailView.swift
//  ToDo List
//
//  Created by MyBook on 19.11.2024.
//

import SwiftUI

struct DetailView: View {
    
    @State var title = "Почитать"
    @State var text = "Составить список необходимых продуктов для ужина. Не забыть проверить, что уже есть в холожильнике"
    var date = "02/10/24"
    
    init(toDoTask: ToDoTask) {
        _title = State(initialValue: toDoTask.todo)
        _text = State(initialValue: "")
        self.date = "02/10/24"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            TextField("Enter title", text: $title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(date)
                .foregroundStyle(.secondary)
            
            TextEditor(text: $text)
            
        }
        .padding(.horizontal)
        //.navigationBarHidden(true)
    }
}

#Preview {
    DetailView(toDoTask: .mock)
}
