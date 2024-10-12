//
//  mBudgetApp.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/13.
//
import FirebaseCore
import SwiftUI

@main
struct mBudgetApp: App {
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
