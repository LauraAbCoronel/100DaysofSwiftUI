//
//  AddView.swift
//  Project-07-iExpense
//
//  Created by Laura Coronel on 8/7/23.
//

import SwiftUI

struct AddView: View {
	@ObservedObject var expenses: Expenses
	
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
				
				TextField("Amount", value: $amount, format: .currency(code: "USD"))
					.keyboardType(.decimalPad)
			}
			.navigationTitle("Add new expense")
		}
    }
}

#Preview {
    AddView(expenses: Expenses())
}
