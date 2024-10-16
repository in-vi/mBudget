//
//  listView.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/13.
//

import FirebaseFirestore
import SwiftUI

struct listView: View {
    @StateObject var viewModel : listViewViewModel
    @FirestoreQuery var items: [TodoListItem]
    @State private var selectedMonth: Date = Date()
    
    
    init (userId:String) {
        
        // users/<id>/todos/<entries>
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/todos"
        )
        self._viewModel = StateObject(
            wrappedValue: listViewViewModel(userId: userId )
        )
    }
        // Format the currently selected month as "MMMM yyyy" (e.g., "October 2024")
        private var formattedMonth: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM yyyy"
            return formatter.string(from: selectedMonth)
        }
        
    private func previousMonth() {
        if let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: selectedMonth) {
            selectedMonth = previousMonth
            viewModel.fetchItems(for: selectedMonth) // Fetch items for the new month
        }
    }

    private func nextMonth() {
        if let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: selectedMonth) {
            selectedMonth = nextMonth
            viewModel.fetchItems(for: selectedMonth) // Fetch items for the new month
        }
    }

    
    var body: some View {
        NavigationView{
            VStack{
                
                // Display the current month with arrow buttons
                HStack {
                    Button(action: previousMonth) {
                        Image(systemName: "chevron.left")
                    }
                    
                    Text(formattedMonth)
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)
                    
                    Button(action: nextMonth) {
                        Image(systemName: "chevron.right")
                    }
                }
                .padding(.top)
                List(viewModel.items) { item in
                    todoListItemView(item: item)
                        .swipeActions {
                            Button {
                                // delete action
                                viewModel.delete(id: item.id)
                            } label: {
                                Image(systemName: "minus.diamond")
                            }
                            .tint(.red)
                        }
                }

                .listStyle(PlainListStyle())
                
            }
            .navigationTitle("mBudget")
            
            .toolbar{
                Button{
                    viewModel.showingNewItem = true
                }label:
                {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewItem) {
                itemView(newItemPresented: $viewModel.showingNewItem) {
                    // This closure will be called when a new item is saved
                    viewModel.fetchItems(for:selectedMonth) // Refresh the items
                }
            }

        }
    }
}

#Preview {
    listView(userId: "2sWOdN7nlbasXo8wt9jBUT6xZp82")
}
