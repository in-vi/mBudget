//
//  ActualsView.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/17.
//

import SwiftUI

struct ActualsView: View {
    var projectedValue: Double
    var actualValue: Double

    var body: some View {
        VStack(spacing: 20) { // Spacing between items for clarity
            // Actual Value
            HStack {
                Text("Actuals:")
                    .bold()
                    .foregroundColor(.green)
                Spacer()
                Text("\(actualValue, specifier: "%.2f")")
                    .foregroundColor(.green)
            }
            .padding(.horizontal)

            // Projected Value
            HStack {
                Text("Projected:")
                    .bold()
                    .foregroundColor(.blue)
                Spacer()
                Text("\(projectedValue, specifier: "%.2f")")
                    .foregroundColor(.blue)
            }
            .padding(.horizontal)

            // Divider line between Projected and Difference
            Divider()
                .padding(.horizontal)

            // Difference Value
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
        .padding() // Padding around the entire view
        .background(Color.white) // Set background color
        .cornerRadius(15) // Rounded corners
        .shadow(radius: 10) // Shadow for depth
    }
}

// Preview Provider
struct ActualsView_Previews: PreviewProvider {
    static var previews: some View {
        ActualsView(projectedValue: 150000.00, actualValue: 175000.00) // Example values for preview
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
