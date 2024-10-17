//
//  listViewViewModel.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/13.
//

import FirebaseFirestore
import SwiftUI

class ListViewViewModel: ObservableObject {
    @Published var showingNewItem = false
    @Published var items: [TodoListItem] = []
    
    @Published var projectedValue: Double = 0.0
    @Published var actualValue: Double = 0.0
    
    private let userId: String
    private var db: Firestore { Firestore.firestore() }
    
    init(userId: String) {
        self.userId = userId
        fetchItems(for: Date()) // Fetch items for the current month on initialization
        fetchProjectedValue(for: Date()) // Fetch projected value for the current month
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
                
                // Calculate actual value
                self?.calculateActualValue()
            }
    }
    
    // Fetch projected value for a specific month
    func fetchProjectedValue(for month: Date) {
        let calendar = Calendar.current
        let monthKey = calendar.date(from: calendar.dateComponents([.year, .month], from: month))!.timeIntervalSince1970
        
        db.collection("users").document(userId).collection("projectedValues").document(String(monthKey))
            .getDocument { [weak self] document, error in
                if let document = document, document.exists,
                   let data = document.data(), let value = data["projectedValue"] as? Double {
                    self?.projectedValue = value
                } else {
                    self?.projectedValue = 0.0 // Default to 0 if no value exists
                }
            }
    }
    
    // Save projected value for a specific month
    func saveProjectedValue(_ value: Double, for month: Date) {
        let calendar = Calendar.current
        let monthKey = calendar.date(from: calendar.dateComponents([.year, .month], from: month))!.timeIntervalSince1970
        
        db.collection("users").document(userId).collection("projectedValues").document(String(monthKey))
            .setData(["projectedValue": value]) { error in
                if let error = error {
                    // Handle error
                    print("Error saving projected value: \(error.localizedDescription)")
                } else {
                    self.projectedValue = value // Update the projected value locally
                }
            }
    }
    
    private func calculateActualValue() {
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
