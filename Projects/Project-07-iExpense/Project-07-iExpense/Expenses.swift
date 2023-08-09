//
//  Expenses.swift
//  Project-07-iExpense
//
//  Created by Laura Coronel on 8/7/23.
//

import Foundation

class Expenses: ObservableObject {
	@Published var items = [ExpenseItem]() {
		didSet {
			let encoder = JSONEncoder()
			
			if let encoded = try? encoder.encode(items) {
				UserDefaults.standard.set(encoded, forKey: "Items")
			}
		}
	}
	
	var personalItems: [ExpenseItem] {
		items.filter { $0.type == "Personal"}
	}
	
	var businessItems: [ExpenseItem] {
		items.filter { $0.type == "Business"}
	}
	
	init() {
		if let savedItems = UserDefaults.standard.data(forKey: "Items") { // read forKey items
			if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) { // if so try to decode 
				items = decodedItems
				return
			}
		}
		items = []
	}
}
