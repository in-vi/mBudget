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
    var body: some View {
        VStack {
            Text("new entry")
                .font(.system(size:32))
                .bold()
                .padding(.top,100)
            Form{
                // Title
                TextField("add item",text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                //TextField("amount",text: $viewModel.amount)
                    //.textFieldStyle(DefaultTextFieldStyle())
               
                // date
                
                DatePicker("add date", selection: $viewModel.date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                // button
                buttonView(name:"add entry",background:.blue)
                {   if viewModel.canSave{
                    // action
                        viewModel.save()
                        newItemPresented = false
                } else{
                    viewModel.showAlert = true
                }
                    
                }
                .padding()
            }
            .alert(isPresented: $viewModel.showAlert){
                Alert(title: Text("Error"),
                      message: Text("Please fill in item and amount correctly"))
            }
        }
    }
}

#Preview {
    itemView(newItemPresented: Binding(get: {return true},
                                       set: { _ in}))
}
