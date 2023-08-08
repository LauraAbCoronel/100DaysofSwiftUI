//
//  ContentView.swift
//  Project-07-iExpense
//
//  Created by Laura Coronel on 8/7/23.
//

import SwiftUI

struct ContentView: View {
	@StateObject var expenses = Expenses()
	@State private var showingAddExpense = false
	
    var body: some View {
		NavigationStack {
			List {
				ForEach(expenses.items) { item in
					Text(item.name)
				}
				.onDelete(perform: { indexSet in
					removeItems(at: indexSet)
				})
			}
			.navigationTitle("iExpense")
			.toolbar {
				Button {
					showingAddExpense = true
				} label: {
					Image(systemName: "plus")
				}
			}
			.sheet(isPresented: $showingAddExpense) {
				AddView(expenses: expenses)
			}
		}
    }
	
	func removeItems(at offset: IndexSet) {
		expenses.items.remove(atOffsets: offset)
	}
}

#Preview {
    ContentView()
}
