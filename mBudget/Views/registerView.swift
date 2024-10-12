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
        headerView(title:"mBudget +",
                   subTitle:"New User Registration",
                   angle:15,
                   background:Color(red: 0.7, green: 0.4, blue: 0.9, opacity: 1.0))
        // register form
        Form{
            TextField("User Name",text:$viewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .autocorrectionDisabled()
            TextField("eMail Id",text:$viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .autocorrectionDisabled()
            
            SecureField("password",text:$viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            buttonView(name:"Create Account",background:.green){
                // action
                viewModel.register()
            }
            .padding()
        }
        //
        Spacer()
    }
}

#Preview {
    registerView()
}
