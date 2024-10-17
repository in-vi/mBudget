//
//  registerViewViewModel.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/13.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation


class registerViewViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""

    func register() {
        guard validateFields() else { return }
        createUser()
    }
    
    private func createUser() {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let userId = result?.user.uid, error == nil else {
                self?.errorMessage = "Error creating user."
                return
            }
            self?.insertUserRecord(id: userId)
        }
    }

    private func insertUserRecord(id: String) {
        let newUser = User(id: id, name: username, email: email, joined: Date().timeIntervalSince1970)
        Firestore.firestore().collection("users").document(id).setData(newUser.asDictionary())
    }

    private func validateFields() -> Bool {
        errorMessage = ""
        if username.isEmpty || email.isEmpty || password.isEmpty {
            errorMessage = "Please fill in all fields"
            return false
        }
        if !email.contains("@") || !email.contains(".") {
            errorMessage = "Enter valid email."
            return false
        }
        if password.count < 6 {
            errorMessage = "Weak password."
            return false
        }
        return true
    }
}

