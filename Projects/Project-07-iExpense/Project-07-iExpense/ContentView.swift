//
//  ContentView.swift
//  Project-07-iExpense
//
//  Created by Laura Coronel on 8/7/23.
//

import SwiftUI

var localCurrency: FloatingPointFormatStyle<Double>.Currency {
	.currency(code: Locale.current.currency?.identifier ?? "USD")
}

struct ContentView: View {
	@StateObject var expenses = Expenses()
	@State private var showingAddExpense = false
	
    var body: some View {
		NavigationStack {
			List {
				ExpenseSection(title: "Business", expenses: expenses.businessItems, deletItems: removeBusinessItems)
				ExpenseSection(title: "Personal", expenses: expenses.personalItems, deletItems: removePersonalItems)
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
	
	func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]) {
		var objectsToDelete = IndexSet()
		
		for offset in offsets {
			let item = inputArray[offset]
			
			if let index = expenses.items.firstIndex(of: item) {
				objectsToDelete.insert(index)
			}
		}
		
		expenses.items.remove(atOffsets: objectsToDelete)
	}
	
	func removePersonalItems(at offsets: IndexSet) {
		removeItems(at: offsets, in: expenses.personalItems)
	}
	
	func removeBusinessItems(at offsets: IndexSet) {
		removeItems(at: offsets, in: expenses.businessItems)
	}
}

#Preview {
    ContentView()
}
