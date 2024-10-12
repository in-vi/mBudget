//
//  todoListViewViewModel.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/13.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation

class todoListViewViewModel : ObservableObject{
    init() {}
    
    func toggleIsDone(item:TodoListItem){
        var itemCopy = item
        itemCopy.setDone(!item.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())
    }
}
