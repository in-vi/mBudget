//
//  listViewViewModel.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/13.
//

import FirebaseFirestore
import SwiftUI

class listViewViewModel: ObservableObject {
    @Published var showingNewItem = false
    @Published var items: [TodoListItem] = []
    
    private let userId: String
    private var db: Firestore { Firestore.firestore() }
    
    init(userId: String) {
        self.userId = userId
        fetchItems(for: Date()) // Fetch items for the current month on initialization
    }
    
    func fetchItems(for month: Date) {
        let calendar = Calendar.current
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: month))!
        let endOfMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth)!
        
        // Fetch items for the selected month
        db.collection("users").document(userId).collection("todos")
            .whereField("date", isGreaterThanOrEqualTo: startOfMonth.timeIntervalSince1970)
            .whereField("date", isLessThan: endOfMonth.timeIntervalSince1970)
            .getDocuments { snapshot, error in
                if let error = error {
                    //print("Error fetching items: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    //print("No documents found.")
                    return
                }
                
                // Map documents to TodoListItem
                self.items = documents.compactMap { try? $0.data(as: TodoListItem.self) }
                //print("Fetched items for month: \(self.items)")
            }
    }
    
    func delete(id: String) {
            db.collection("users")
                .document(userId)
                .collection("todos")
                .document(id)
                .delete() { [weak self] error in
                    if let error = error {
                       // print("Error deleting item: \(error)")
                    } else {
                        self?.fetchItems(for: Date()) // Refresh items after deletion
                    }
                }
        }
}
