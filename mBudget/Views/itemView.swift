//
//  itemView.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/13.
//

import SwiftUI

struct itemView: View {
    @StateObject var viewModel = newItemViewViewModel()
    @Binding var newItemPresented: Bool
    var onItemSaved: (() -> Void)? // Add this property

    var body: some View {
        VStack {
            Text("new entry")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 100)
            Form {
                TextField("add item", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())

                DatePicker("add date", selection: $viewModel.date)
                    .datePickerStyle(GraphicalDatePickerStyle())

                buttonView(name: "add entry", background: .blue) {
                    if viewModel.canSave {
                        viewModel.save()
                        newItemPresented = false
                        onItemSaved?() // Call this to notify the listView
                    } else {
                        viewModel.showAlert = true
                    }
                }
                .padding()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"),
                      message: Text("Please fill in item and amount correctly"))
            }
        }
    }
}
