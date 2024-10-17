//
//  listViewViewModel.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/13.
//

import FirebaseFirestore
import SwiftUI

// ...

class listViewViewModel: ObservableObject {
    @Published var showingNewItem = false
    @Published var items: [TodoListItem] = []
    
    // New properties for projected and actual values
    @Published var projectedValue: Double = 0.0
    @Published var actualValue: Double = 0.0
    
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
            .getDocuments { [weak self] snapshot, error in
                if error != nil {
                    // Handle error
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    // Handle no documents found
                    return
                }
                
                // Map documents to TodoListItem
                self?.items = documents.compactMap { try? $0.data(as: TodoListItem.self) }
                
                // Calculate projected and actual values
                self?.calculateValues()
            }
    }
    
    // New method to calculate projected and actual values
    private func calculateValues() {
        // Replace the following logic with your actual calculations
        projectedValue = 100.0 // Example projected value
        
        // Convert string amounts to double and calculate actual value
        actualValue = items.reduce(0) { (result, item) in
            if let amount = Double(item.amount) {
                return result + amount
            } else {
                return result // Ignore if conversion fails
            }
        }
    }
    
    func delete(id: String) {
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete() { [weak self] error in
                if error != nil {
                    // Handle deletion error
                } else {
                    self?.fetchItems(for: Date()) // Refresh items after deletion
                }
            }
    }
}
