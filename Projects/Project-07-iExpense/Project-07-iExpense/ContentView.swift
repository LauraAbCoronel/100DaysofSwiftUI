//
//  ContentView.swift
//  Project-07-iExpense
//
//  Created by Laura Coronel on 8/7/23.
//

import SwiftUI

struct ContentView: View {
	@StateObject var expenses = Expenses()
	
    var body: some View {
		NavigationStack {
			List {
				ForEach(expenses.items, id: \.name) { item in
					Text(item.name)
				}
				.onDelete(perform: { indexSet in
					removeItems(at: indexSet)
				})
			}
			.navigationTitle("iExpense")
			.toolbar {
				Button {
					let expense = ExpenseItem(name: "Test", type: "Personal", ammount: 5)
					expenses.items.append(expense)
				} label: {
					Image(systemName: "plus")
				}
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
