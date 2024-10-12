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
    
    init (userId:String) {
        
        // users/<id>/todos/<entries>
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/todos"
        )
        self._viewModel = StateObject(
            wrappedValue: listViewViewModel(userId: userId )
        )
    }
    var body: some View {
        NavigationView{
            VStack{
      
                List(items) {item in
                    todoListItemView(item: item)
                        .swipeActions{
                            Button{
                                // delete action
                                viewModel.delete(id: item.id)
                            }label:
                            {
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
            .sheet(isPresented: $viewModel.showingNewItem){
                itemView(newItemPresented: $viewModel.showingNewItem)
            }
        }
    }
}

#Preview {
    listView(userId: "2sWOdN7nlbasXo8wt9jBUT6xZp82")
}
