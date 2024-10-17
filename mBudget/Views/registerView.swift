//
//  registerView.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/13.
//

import SwiftUI

struct registerView: View {
    @StateObject var viewModel = registerViewViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Header
                    headerView(title: "mBudget +",
                               subTitle: "New User Registration",
                               angle: 15,
                               background: Color(red: 0.7, green: 0.4, blue: 0.9, opacity: 1.0))
                    
                    // Registration Form
                    TextField("User Name", text: $viewModel.username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .padding(.horizontal) // Horizontal padding
                        .frame(maxWidth: 300) // Limit width of TextField
                    
                    TextField("Email ID", text: $viewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .padding(.horizontal) // Horizontal padding
                        .frame(maxWidth: 300) // Limit width of TextField
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal) // Horizontal padding
                        .frame(maxWidth: 300) // Limit width of SecureField
                    
                    buttonView(name: "Create Account", background: .green) {
                        // Action
                        viewModel.register()
                    }
                    .padding() // Add padding around the button
                    .frame(maxWidth: 300) // Limit width of Button
                    
                    Spacer()
                }
                .padding() // Overall padding for the ScrollView
                .frame(maxWidth: .infinity) // Allow VStack to take full width
            }
            
        }
    }
}

#Preview {
    registerView()
}
