//
//  profileView.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/13.
//

import SwiftUI

struct profileView: View {
    @StateObject var viewModel = profileViewViewModel()
    
    init () {
        
    }
    var body: some View {
        NavigationView{
            VStack{
                if let user = viewModel.user{
                    // Avatar
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.blue)
                        .frame(width: 125,height: 125)
                        .padding()
                    // info
                    VStack(alignment: .leading){
                        HStack{
                            Text("Name: ").bold()
                            Text(user.name)
                        }
                    }
                    .padding()
                    // signout
                    Button("Log Out"){
                        viewModel.logout()
                    }
                    .tint(.red)
                    .padding()
                    Spacer()
                }
            }
            .navigationTitle("Profile")
        }
        .onAppear{
            viewModel.fetchUser()
        }
    }
}

#Preview {
    profileView()
}
