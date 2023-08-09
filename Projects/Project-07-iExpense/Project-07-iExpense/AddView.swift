//
//  AddView.swift
//  Project-07-iExpense
//
//  Created by Laura Coronel on 8/7/23.
//

import SwiftUI

struct AddView: View {
	@ObservedObject var expenses: Expenses
	@Environment(\.dismiss) var dismiss
	
	@State private var name = ""
	@State private var type = "Personal"
	@State private var amount = 0.0
	
	let types = ["Business", "Personal"]
	
    var body: some View {
		NavigationStack {
			Form {
				TextField("Name", text: $name)
				
				Picker("Type", selection: $type) {
					ForEach(types, id: \.self) {
						Text($0)
					}
				}
				
				TextField("Amount", value: $amount, format: .localCurrency)
					.keyboardType(.decimalPad)
			}
			.navigationTitle("Add new expense")
			.toolbar {
				Button("Save") {
					let item = ExpenseItem(name: name, type: type, amount: amount)
					expenses.items.append(item)
					dismiss()
				}
			}
		}
    }
}

#Preview {
    AddView(expenses: Expenses())
}
