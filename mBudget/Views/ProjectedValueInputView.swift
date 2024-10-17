//
//  ProjectedValueInputView.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/17.
//

import SwiftUI

struct ProjectedValueInputView: View {
    @Binding var isPresented: Bool
    @Binding var projectedValue: String
    var onSave: (Double) -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Enter Projected Value")
                .font(.headline)
            
            TextField("Projected Value", text: $projectedValue)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                .foregroundColor(.red)

                Spacer()

                Button("Save") {
                    if let value = Double(projectedValue) {
                        onSave(value)
                        isPresented = false
                    }
                }
                .foregroundColor(.blue)
            }
        }
        .padding()
        .frame(maxWidth: 300)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}


