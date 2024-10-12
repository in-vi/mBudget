//
//  listViewViewModel.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/13.
//

import FirebaseFirestore
import Foundation
 // todolist list view primary tab

class listViewViewModel : ObservableObject{
    @Published var showingNewItem = false
    
    private let userId:String
    init(userId:String) {
        self.userId = userId
    }
    
    func delete(id: String){
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
    }
}
