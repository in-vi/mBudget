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
    
    func toggleIsDone(item: TodoListItem, completion: @escaping (TodoListItem) -> Void) {
            var updatedItem = item
            updatedItem.isDone.toggle()  // Toggle the done status
            
            let db = Firestore.firestore()
            let userId = Auth.auth().currentUser?.uid ?? "unknownUser"
            
            db.collection("users")
                .document(userId)
                .collection("todos")
                .document(item.id)
                .updateData(["isDone": updatedItem.isDone]) { error in
                    if let error = error {
                        print("Error updating isDone: \(error)")
                        return
                    }
                    
                    // Call completion with updated item so that UI can refresh
                    completion(updatedItem)
                }
        }
    
}
