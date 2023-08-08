//
//  Expenses.swift
//  Project-07-iExpense
//
//  Created by Laura Coronel on 8/7/23.
//

import Foundation

class Expenses: ObservableObject {
	@Published var items = [ExpenseItem]()
}
