//
//  registerViewViewModel.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/13.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation


class registerViewViewModel: ObservableObject{
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    init () {}
    
    func register(){
        guard validate() else{
            return
        }
        // try register new user
        Auth.auth().createUser(withEmail: email, password: password){ [weak self]
            result, error in
            guard let userId = result?.user.uid else {
                return
            }
            
            self?.insertUserRecord(id: userId)
        }
    }
    
    private func insertUserRecord(id:String){
        
        let newUser = User(id: id,
                           name: username,
                           email: email,
                           joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        
        db.collection("users") // create a collection in firebase as users
            .document(id)
            .setData(newUser.asDictionary())
        
    }
    
    private func validate() -> Bool{
        errorMessage = ""
        
        guard !username.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else{
            errorMessage = "Please fill in all fields"
            return false
        }
        
        guard email.contains("@") && email.contains(".") else{
            errorMessage = "Enter valid eMail."
            return false
        }
        
        guard password.count >= 6 else{
            errorMessage = "weak password"
            return false
        }
        return true
        
    }
    
}
