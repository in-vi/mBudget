//
//  itemView.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/13.
//

import SwiftUI

struct ItemView: View {
    @StateObject var viewModel = NewItemViewViewModel()
    @Binding var newItemPresented: Bool
    var onItemSaved: (() -> Void)?

    @State private var selectedCategory: Category?

    var categories: [Category] = [
        Category(id: UUID().uuidString, name: "Groceries", iconName: "cart"),
        Category(id: UUID().uuidString, name: "Utilities", iconName: "bolt"),
        Category(id: UUID().uuidString, name: "Food", iconName: "fork.knife")
    ]

    var body: some View {
        VStack {
            Text("New Entry")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 50)

            if selectedCategory == nil {
                CategoryView(categories: categories, selectedCategory: $selectedCategory)

                Text("Please select a category to add items.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                Text("Selected Category: \(selectedCategory?.name ?? "")")
                    .font(.headline)
                    .padding(.bottom, 10)

                Form {
                    TextField("Add item", text: $viewModel.title)
                        .textFieldStyle(DefaultTextFieldStyle())
                    TextField("Enter amount", text: $viewModel.amount)
                        .keyboardType(.decimalPad)

                    DatePicker("Add date", selection: $viewModel.date)
                        .datePickerStyle(CompactDatePickerStyle())

                    buttonView(name: "Add Entry", background: .blue) {
                        if viewModel.canSave {
                            guard let selectedCategory = selectedCategory else {
                                viewModel.showAlert = true
                                return
                            }
                            // Create the new item
                            let newItem = TodoListItem(
                                id: UUID().uuidString,
                                title: viewModel.title,
                                date: viewModel.date.timeIntervalSince1970,
                                createdDate: Date().timeIntervalSince1970,
                                isDone: false,
                                amount: viewModel.amount,
                                category: selectedCategory  // Assign the selected category
                            )
                            
                            // Save the item
                            viewModel.save(item: newItem)
                            newItemPresented = false
                            onItemSaved?()
                        } else {
                            viewModel.showAlert = true
                        }
                    }
                    .padding()
                }
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Error"),
                          message: Text("Please fill in all fields correctly."))
                }
            }
        }
    }
}

