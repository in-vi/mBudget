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
        NavigationView{
            VStack{
                // header
                headerView(title:"mBudget +",
                           subTitle:"Utilities",
                           angle:-15,
                           background:.blue)
                // login form
                Form{
                    // error msg
                    if  !viewModel.errorMessage.isEmpty{
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red)
                    }
                    //
                    TextField("eMail Id",text:$viewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                    
                    SecureField("password",text:$viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    buttonView(name:"log in",background:.blue){
                        // action
                        viewModel.login()
                    }
                    .padding()
                }
                // create account
                VStack{
                    Text("New User ?")
                    
                    NavigationLink("Create An Account",
                        destination:registerView())
                    }
                    .padding(.bottom, 50.0)
                    Spacer()
            }
        }
    }
}

#Preview {
    loginView()
}
