//
//  ActualsView.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/17.
//

import SwiftUI

struct ActualsView: View {
    @State private var isInputPresented = false
    @State private var userProjectedValue: String = ""

    var projectedValue: Double
    var actualValue: Double
    var saveProjectedValue: (Double) -> Void

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Actuals:")
                    .bold()
                    .foregroundColor(.green)
                Spacer()
                Text("\(actualValue, specifier: "%.2f")")
                    .foregroundColor(.green)
            }
            .padding(.horizontal)

            HStack {
                Text("Projected:")
                    .bold()
                    .foregroundColor(.blue)
                Spacer()
                Text("\(projectedValue, specifier: "%.2f")")
                    .foregroundColor(.blue)
            }
            .padding(.horizontal)
            .onTapGesture {
                userProjectedValue = "\(projectedValue)"
                isInputPresented = true
            }

            Divider()
                .padding(.horizontal)

            HStack {
                Text("Difference:")
                    .bold()
                    .foregroundColor(.orange)
                Spacer()
                Text("\(actualValue - projectedValue, specifier: "%.2f")")
                    .foregroundColor(.orange)
            }
            .padding(.horizontal)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 10)
        .sheet(isPresented: $isInputPresented) {
            ProjectedValueInputView(isPresented: $isInputPresented, projectedValue: $userProjectedValue) { value in
                saveProjectedValue(value) // Save projected value
            }
        }
    }
}


// Preview Provider
struct ActualsView_Previews: PreviewProvider {
    static var previews: some View {
        ActualsView(projectedValue: 150000.00, actualValue: 175000.00, saveProjectedValue: { _ in })
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
