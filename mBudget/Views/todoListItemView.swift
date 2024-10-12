//
//  todoListItemView.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/13.
//

import SwiftUI

struct todoListItemView: View {
    @StateObject var viewModel = todoListViewViewModel()
    let item: TodoListItem
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(item.title)
                    .bold()
                    .font(.body)
                Text("\(Date(timeIntervalSince1970: item.date).formatted(date:.abbreviated,time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
            }
            
            Spacer()
            
            Button{
                viewModel.toggleIsDone(item:item)
            } label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(Color.blue)
            }
        }
    }
}

#Preview {
    todoListItemView(item: .init(
        id : "123",
        title: "eggs",
        date: Date().timeIntervalSince1970,
        createdDate: Date().timeIntervalSince1970,
        isDone: true,
        amount: "50"
    ))
}
