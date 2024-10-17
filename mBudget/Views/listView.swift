//
//  listView.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/13.
//

import FirebaseFirestore
import SwiftUI

struct listView: View {
    @StateObject var viewModel: listViewViewModel
    @FirestoreQuery var items: [TodoListItem]
    @State private var selectedMonth: Date = Date()
    @State private var isActualsViewPresented: Bool = false // State variable for ActualsView

    init(userId: String) {
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos")
        self._viewModel = StateObject(wrappedValue: listViewViewModel(userId: userId))
    }

    private var formattedMonth: String {
        DateFormatter.localizedString(from: selectedMonth, dateStyle: .long, timeStyle: .none)
    }

    private func updateMonth(byAddingMonths months: Int) {
        if let newMonth = Calendar.current.date(byAdding: .month, value: months, to: selectedMonth) {
            selectedMonth = newMonth
            viewModel.fetchItems(for: selectedMonth)
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                ActualsView(projectedValue: viewModel.projectedValue, actualValue: viewModel.actualValue) // Pass values
                    .transition(.slide) // Optional for nice transition
                    .padding()
                monthSelectionView
                todoListView
                
            }
            .navigationTitle("mBudget")
            .toolbar {
                addItemButton
            }
            .sheet(isPresented: $viewModel.showingNewItem) {
                itemView(newItemPresented: $viewModel.showingNewItem) {
                    viewModel.fetchItems(for: selectedMonth)
                }
            }
        }
    }

    private var monthSelectionView: some View {
        VStack{
           
            HStack {
                Button(action: { updateMonth(byAddingMonths: -1) }) {
                    Image(systemName: "chevron.left")
                }
                
                Text(formattedMonth)
                    .font(.title2)
                    .bold()
                    .padding(.horizontal)
                    
                Button(action: { updateMonth(byAddingMonths: 1) }) {
                    Image(systemName: "chevron.right")
                }
                
            }
            
        }
        .padding(.top)
    }

    private var todoListView: some View {
        List(viewModel.items) { item in
            todoListItemView(item: item)
                .swipeActions {
                    Button {
                        viewModel.delete(id: item.id)
                    } label: {
                        Image(systemName: "minus.diamond")
                    }
                    .tint(.red)
                }
        }
        .listStyle(PlainListStyle())
    }

    private var addItemButton: some View {
        Button {
            viewModel.showingNewItem = true
        } label: {
            Image(systemName: "plus")
        }
    }
}

#Preview {
    listView(userId: "2sWOdN7nlbasXo8wt9jBUT6xZp82")
}
