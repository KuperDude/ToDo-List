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
    
    @State private var isOn = false
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: isOn ? "circle" : "checkmark.circle")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(isOn ? .secondary : .accent)
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .strikethrough(!isOn, color: .secondary)
                    .font(.title)
                    .frame(height: 30)
                    
                Text(text)
                    .lineLimit(2)
                Text(date)
                    .foregroundStyle(.secondary)
            }
            .foregroundStyle(isOn ? .primary : .secondary)
        }
        .onTapGesture {
            isOn.toggle()
        }
    }
}

#Preview {
    HomeCell()
}
