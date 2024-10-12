//
//  ContentView.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/13.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = contentViewViewModel()
    
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty{
            // signed in
            accountView
            
        }else{
            loginView()
        }
        
    }
    @ViewBuilder
    var accountView: some View{
        TabView {
            listView(userId: viewModel.currentUserId)
                .tabItem{
                    Label("Home",systemImage: "house")
                }
            profileView()
                .tabItem{
                    Label("Profile",systemImage: "person.circle")
                }
        }

    }
}

#Preview {
    ContentView()
}
