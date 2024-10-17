//
//  loginView.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/13.
//

import SwiftUI

struct loginView: View {
    @StateObject var viewModel = loginViewViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView { // Keep ScrollView here
                VStack(spacing: 20) { // Use VStack to layout elements
                    // Header
                    headerView(title: "mBudget +",
                               subTitle: "Utilities",
                               angle: -15,
                               background: .blue)
                    
                    // Error message
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red)
                            .padding() // Add padding to the error message
                    }
                    
                    // Login Form
                    TextField("Email ID", text: $viewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .padding(.horizontal) // Add horizontal padding
                        .frame(maxWidth: 300) // Limit width of TextField
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal) // Add horizontal padding
                        .frame(maxWidth: 300) // Limit width of SecureField
                    
                    buttonView(name: "Log In", background: .blue) {
                        // Action
                        viewModel.login()
                    }
                    
                    
                    // Create Account Section
                    Spacer()
                    VStack {
                        Text("New User?")
                        NavigationLink("Create An Account", destination: registerView())
                    }
                    .padding(.bottom, 50.0)

                    
                }
                .padding() // Add overall padding for the ScrollView
                .frame(maxWidth: .infinity) // Ensure VStack takes full width
            }
            
        }
    }
}

#Preview {
    loginView()
}
