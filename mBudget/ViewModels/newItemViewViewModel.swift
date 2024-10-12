//
//  newItemViewViewModel.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/14.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class newItemViewViewModel : ObservableObject{
    @Published var title = ""
    @Published var date = Date()
    @Published var amount = ""
    @Published var showAlert = false
    
    init() {}
    
    func save(){
        // try saving
        guard canSave else{
            return
        }
        // get current userid
        guard let uId = Auth.auth().currentUser?.uid else{
            return
        }
        // create model
        let newId = UUID().uuidString
        let newItem = TodoListItem(
            id: newId,
            title: title,
            date: date.timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            isDone: false,
            amount : amount)
        
        // save model
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uId)
            .collection("todos")
            .document(newId)
            .setData(newItem.asDictionary())
    }
    
    var canSave: Bool{
        
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty//,
              //!amount.trimmingCharacters(in: .whitespaces).isEmpty
        else{
            return false
        }
        return true
    }
}
