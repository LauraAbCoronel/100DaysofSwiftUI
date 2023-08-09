//
//  ExpenseSection.swift
//  Project-07-iExpense
//
//  Created by Laura Coronel on 8/8/23.
//

import SwiftUI

struct ExpenseSection: View {
	let title: String
	let expenses: [ExpenseItem]
	let deletItems: (IndexSet) -> Void
	
	var body: some View {
		Section(title) {
			ForEach(expenses) { item in
				if item.type == title {
					HStack {
						VStack(alignment: .leading) {
							Text(item.name)
								.font(.headline)
							Text(item.type)
						}
						Spacer()
						
						Text(item.amount, format: .localCurrency)
							.style(for: item)
					}
				}
			}
			.onDelete(perform: deletItems)
		}
	}
}

//#Preview {
//	ExpenseSection(title: "Example", expenses: []) { _ in }
//}
