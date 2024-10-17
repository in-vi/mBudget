//
//  newItemViewViewModel.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/14.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class NewItemViewViewModel: ObservableObject {
    @Published var title = ""
    @Published var date = Date()
    @Published var amount = ""
    @Published var showAlert = false

    var onItemSaved: (() -> Void)?

    init() {}

    // Updated save method to accept a TodoListItem
    func save(item: TodoListItem) {
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }

        let db = Firestore.firestore()
        db.collection("users")
            .document(uId)
            .collection("todos")
            .document(item.id)
            .setData(item.asDictionary()) { error in
                if error == nil {
                    self.onItemSaved?() // Notify that an item has been saved
                }
            }
    }

    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty,
              !amount.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        return true
    }
}
