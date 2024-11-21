//
//  DetailView.swift
//  ToDo List
//
//  Created by MyBook on 19.11.2024.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var presenter: DetailPresenter

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            TextField("Введите заголовок", text: $presenter.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(presenter.creationDate)
                .foregroundStyle(.secondary)
            
            ZStack {
                if presenter.text.isEmpty {
                    TextEditor(text: .constant("Введите описание"))
                            .foregroundColor(.gray)
                            .disabled(true)
                }
                TextEditor(text: $presenter.text)
                    .opacity(presenter.text.isEmpty ? 0.25 : 1)
            }
        }
        .padding(.horizontal)
        .onDisappear {
            presenter.updateTaskOnDisappear()
        }
    }
}

#Preview {
    DetailBuilder.build(with: ToDoTask.mock)
}
