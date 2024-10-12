//
//  contentViewViewModel.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/14.
//

import FirebaseAuth
import Foundation

class contentViewViewModel : ObservableObject {
    @Published var currentUserId: String = ""
    
    private var handler: AuthStateDidChangeListenerHandle?
    init () {
        self.handler = Auth.auth().addStateDidChangeListener{ [weak self] _, user in
            DispatchQueue.main.async{
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    public var isSignedIn : Bool{
        return Auth.auth().currentUser != nil
    }
}
