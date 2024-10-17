//
//  CategoryView.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/16.
//

import SwiftUI

struct CategoryView: View {
    let categories: [Category]
    @Binding var selectedCategory: Category?

    var body: some View {
        VStack {
            Text("Select Category")
                .font(.headline)
                .padding(.top, 20)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(categories) { category in
                        Button(action: {
                            selectedCategory = category  // Set the selected category
                        }) {
                            VStack {
                                Image(systemName: category.iconName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                                    //.padding()
                                Text(category.name)
                                    .font(.headline)
                                    
                            }
                            .frame(width: 100, height: 100)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    CategoryView(categories: [
        Category(id: UUID().uuidString, name: "Groceries", iconName: "cart"),
        Category(id: UUID().uuidString, name: "Utilities", iconName: "bolt"),
        Category(id: UUID().uuidString, name: "Food", iconName: "fork.knife")
    ], selectedCategory: .constant(nil))
}

