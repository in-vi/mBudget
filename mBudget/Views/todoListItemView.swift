//
//  todoListItemView.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/13.
//

import SwiftUI

struct todoListItemView: View {
    @StateObject var viewModel = todoListViewViewModel()
    @State var item: TodoListItem  // Make item mutable to update UI
    
    var body: some View {
        HStack {
            Button {
                viewModel.toggleIsDone(item: item) { updatedItem in
                    self.item = updatedItem  // Update the UI after toggling
                }
            } label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(Color.blue)
            }
            
            VStack(alignment: .leading) {
                // Display category name and icon
                HStack {
                    Image(systemName: item.category.iconName)
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text(item.category.name)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Text(item.title)
                    .bold()
                    .font(.body)
                
                Text("\(Date(timeIntervalSince1970: item.date).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
                
                
                
            }
            
            Spacer()
            Text(item.amount)
                .padding()
        }
    }
}

#Preview {
    todoListItemView(item: .init(
        id: "123",
        title: "Buy Milk",
        date: Date().timeIntervalSince1970,
        createdDate: Date().timeIntervalSince1970,
        isDone: true,
        amount: "50",
        category: Category(id: UUID().uuidString, name: "Groceries", iconName: "cart")
    ))
}
